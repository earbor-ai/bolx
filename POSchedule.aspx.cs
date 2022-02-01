using Npgsql;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class POSchedule : System.Web.UI.Page
{/// <summary>
 /// 
 /// </summary>
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static IList GetEvents()
    {
        IList events = new List<POScheduleEvents>();
        POScheduleModel pOSchedule = new POScheduleModel();
        var eventList = pOSchedule.GetAllPOSchedulesEvents();
        foreach (var obj in eventList)
        {
            // DateTime utcTime = serverTime.ToUniversalTime(); // convert it to Utc using timezone setting of server computer
            string timeZone = ConfigurationManager.AppSettings["TimeZone"];
            TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
            var sTime = obj.ScheduleDate.ToShortDateString() + " " + obj.ScheduleTime;
            // DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(sTime), tzi);
            DateTime localTime = Convert.ToDateTime(sTime);
            //var pstTime = localTime.ToString("HH:mm");

            events.Add(new POScheduleEvents
            {
                id = obj.id,
                PONumber = obj.PONumber,
                ScheduleDate = localTime.ToLocalTime(),
                ScheduleTime = obj.ScheduleTime,
                CustomerName = obj.CustomerName,
                Color = getRandColor(),
                Status = obj.Status
            });
        }
        return events;
    }


    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public static IList GetPONumbers()
    {
        string pono = "a";
        IList events = new List<PONumbers>();
        POScheduleModel pOSchedule = new POScheduleModel();
        var eventList = pOSchedule.GetAllNumbers(pono);
        foreach (var obj in eventList)
        {
            events.Add(new PONumbers
            {
                clientid = obj.clientid,
                ponumber = obj.ponumber,
            });
        }
        return events;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <param name="status"></param>
    /// <param name="date"></param>
    /// <returns></returns>
    [WebMethod]
    public static bool DragUpdatePOScheduleStatus(int id, string status, DateTime date)
    {
        POScheduleModel obj = new POScheduleModel();
        return obj.DragUpdatePOScheduleStatus(id, status, date);
    }
    /// <summary>
    /// 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadClient();
            LoadCarrier();
            LoadCarrierType();
            dtSchedule.Value = DateTime.Now.ToString("dd/MM/yyyy");
            DateTime serverTime = DateTime.Now; // gives you current Time in server timeZone
            DateTime utcTime = serverTime.ToUniversalTime(); // convert it to Utc using timezone setting of server computer
            string timeZone = ConfigurationManager.AppSettings["TimeZone"];
            TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
            DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, tzi);


            txtscheduleTime.Value = localTime.ToString("HH:mm");
            txtnoofboxes.Text = "";
            txtnoofpallets.Text = "";


        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        bool result = false;
        try
        {
            string n = String.Format("{0}", Request.QueryString["ddlPoNumber"]);
            POScheduleModel pOSchedule = new POScheduleModel();
            pOSchedule.ponumber = hdnponumber.Value;
            pOSchedule.customerid = Convert.ToInt32(ddlClient.SelectedItem.Value);
            pOSchedule.customername = ddlClient.SelectedItem.Text;
            pOSchedule.warehouseid = Convert.ToInt32(Session["WarehouseId"]);
            pOSchedule.carrierid = Convert.ToInt32(ddlCarrier.SelectedItem.Value);
            pOSchedule.carriertypeid = Convert.ToInt32(ddlCarrierType.SelectedItem.Value);
            pOSchedule.schdate = Convert.ToDateTime(dtSchedule.Value);
            pOSchedule.schtime = TimeSpan.Parse(txtscheduleTime.Value);
            pOSchedule.noofboxes = Convert.ToInt32(txtnoofboxes.Text);
            pOSchedule.noofpallets = Convert.ToInt32(txtnoofpallets.Text);
            pOSchedule.waittime = ddlWaittime.SelectedItem.Value;
            pOSchedule.comments = comments.Value;
            pOSchedule.createddate = DateTime.UtcNow;
            pOSchedule.createddatetime = DateTime.UtcNow;
            pOSchedule.lastmodifieddate = DateTime.UtcNow;
            pOSchedule.lastmodifiedtime = DateTime.UtcNow;
            pOSchedule.isrescheduled = false;
            pOSchedule.createduserid = Convert.ToInt32(Session["EntryUserID"]);
            result = pOSchedule.SavePOSchedule(pOSchedule);
            if (result == true)
            {
                ddlClient.ClearSelection();
                ddlCarrier.ClearSelection();
                ddlCarrierType.ClearSelection();
                ddlWaittime.ClearSelection();
                txtnoofboxes.Text = "";
                txtnoofpallets.Text = "";
                comments.Value = "";

            }

        }
        catch (Exception ex)
        {

        }

    }
    /// <summary>
    /// 
    /// </summary>
    protected void LoadClient()
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select ClientID,ClientName from whclient Order By ClientName", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlClient.DataSource = ddlSearchClientDT;
            ddlClient.DataTextField = "ClientName";
            ddlClient.DataValueField = "ClientID";
            ddlClient.DataBind();
            ddlClient.Items.Insert(0, new ListItem("-- Select Client --", String.Empty));
        }
        catch (Exception ex)
        {

        }

    }
    /// <summary>
    /// 
    /// </summary>
    protected void LoadCarrier()
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select carrierid,carriername from carriers where isactive = true Order By carriername", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlCarrier.DataSource = ddlSearchClientDT;
            ddlCarrier.DataTextField = "carriername";
            ddlCarrier.DataValueField = "carrierid";
            ddlCarrier.DataBind();
            ddlCarrier.Items.Insert(0, new ListItem("-- Select Carrier --", String.Empty));
        }
        catch (Exception ex)
        {

        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void LoadCarrierType()
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select carriertypeid,carriertypename from carriertype where isactive = true Order By carriertypename", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlCarrierType.DataSource = ddlSearchClientDT;
            ddlCarrierType.DataTextField = "carriertypename";
            ddlCarrierType.DataValueField = "carriertypeid";
            ddlCarrierType.DataBind();
            ddlCarrierType.Items.Insert(0, new ListItem("-- Select Carrier Type--", String.Empty));
        }
        catch (Exception ex)
        {

        }

    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public static string getRandColor()
    {
        Random rnd = new Random();
        string hexOutput = String.Format("{0:X}", rnd.Next(0, 0xFFFFFF));
        while (hexOutput.Length < 6)
            hexOutput = "0" + hexOutput;
        return "#" + hexOutput;
    }
}