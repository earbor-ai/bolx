using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class POScheduleDashboard : System.Web.UI.Page
{ /// <summary>
  /// 
  /// </summary>
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());
    List<POScheduleModel> POScheduleModelList { set; get; }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    [WebMethod]
    public static bool DeleteEvent(int id)
    {
        POScheduleModel obj = new POScheduleModel();
        return obj.DeletePOReschedule(id);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    [WebMethod]
    public static List<POScheduleModel> POScheduleEdit(int id)
    {
        POScheduleModel obj = new POScheduleModel();
        return obj.GetPOSchedulesById(id);
    }

    [WebMethod]
    public static bool UpdatePOScheduleStatus(int id, string status, int noofpackets, string starttime,
        string endtime, string ponumber, int clientid, int carrierid, int carriertypeid, string schdate, string schtime, string waittime, int noofboxes, int noofpallets, string comments)
    {
        if (status == "Acknowledge")
        {

            DateTime serverTime = DateTime.Now; // gives you current Time in server timeZone
            DateTime utcTime = serverTime.ToUniversalTime(); // convert it to Utc using timezone setting of server computer
            string timeZone = ConfigurationManager.AppSettings["TimeZone"];
            TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
            DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, tzi);
            starttime = localTime.ToString("HH:mm");
        }
        POScheduleModel obj = new POScheduleModel();
        return obj.UpdatePOScheduleStatus(id, status, noofpackets, starttime, endtime, ponumber, clientid, carrierid, carriertypeid, schdate, schtime, waittime, noofboxes, noofpallets, comments);
    }


    [WebMethod]
    public static bool UpdateStatusAction(int id, string status)
    {
        string starttime = "";
        if (status == "Acknowledge")
        {

            DateTime serverTime = DateTime.Now; // gives you current Time in server timeZone
            DateTime utcTime = serverTime.ToUniversalTime(); // convert it to Utc using timezone setting of server computer
            string timeZone = ConfigurationManager.AppSettings["TimeZone"];
            TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
            DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, tzi);
            starttime = localTime.ToString("HH:mm");
        }
        else
        {
            starttime = "00:00";
        }
        POScheduleModel obj = new POScheduleModel();
        return obj.UpdatePOScheduleStatus(id, status, starttime);
    }


    /// <summary>
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
            LoadPONumbers();
            var result = LoadPOSchudule();
            StringBuilder poSchudule = new StringBuilder();
            string TotalSKUCount = "";
            foreach (var obj in result)
            {
                POScheduleModel objm = new POScheduleModel();
                TotalSKUCount = objm.GetSKUCountByPONumber(obj.ponumber);
                if (string.IsNullOrEmpty(TotalSKUCount))
                {
                    TotalSKUCount = "0/0";
                }
                DateTime datevariable = new DateTime(obj.schtime.Ticks);
                var sTime = datevariable.ToString("hh:mm tt");

                string statusStr = string.Empty;
                string actionTD = "<td class='text-center'>" +
                    "<div class='list-icons d-inline-flex'>" +
                    "<div class='list-icons-item dropdown'>" +
                    "<div class='list-icons d-inline-flex'><a href = '#' class=' btn-sm  btn-warning list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Edit PO Sehedule'  id='btnView' onclick='openEditModelWin(" + obj.id + ")'><i class=' fa fa-pencil'></i></a><a href = '#' class=' btn-sm  btn-danger list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Acknowledge' id='btnView' onclick='ChangeAknowlege(" + obj.id + ")'><i class=' fa fa-bell'></i></a><a href = '#' class=' btn-sm  badge-danger-red list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Hold'  id='btnView' onclick='ChangeHold(" + obj.id + ")'><i class=' fa fa-archive'></i></a></div></div></div></td>";
                if (obj.status == "Scheduled")
                {
                    statusStr = "<span class='badge badge-pill badge-primary'>" + obj.status + "</span>";
                }
                else if (obj.status == "Reschedule")
                {
                    statusStr = "<span class='badge badge-pill badge-warning'>" + obj.status + "</span>";
                }
                else if (obj.status == "Completed")
                {
                    statusStr = "<span class='badge badge-pill badge-success'>" + obj.status + "</span>";
                    actionTD = "<td class='text-center'>" +
                  "<div class='list-icons d-inline-flex'>" +
                  "<div class='list-icons-item dropdown'>" +
                  "<div class='list-icons d-inline-flex'><a href = '#' class=' btn-sm  btn-warning list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Edit PO Sehedule'  id='btnView' onclick='openEditModelWin(" + obj.id + ")'><i class=' fa fa-pencil'></i></a><a href = '#' class=' btn-sm  btn-default list-icons-item me-10' style=' pointer-events: none' data-bs-toggle='tooltip' data-bs-original-title='Acknowledge' id='btnView' onclick='ChangeAknowlege(" + obj.id + ")'><i class=' fa fa-bell'></i></a><a href = '#' style='pointer-events: none' class=' btn-sm  btn-default list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Hold'  id='btnView' onclick='ChangeHold(" + obj.id + ")'><i class=' fa fa-archive'></i></a></div></div></div></td>";
                }
                else if (obj.status == "Acknowledge")
                {
                    statusStr = "<span class='badge badge-pill badge-danger'>" + obj.status + "</span>";
                    // actionTD = "<td class='text-center'><div class='list-icons d-inline-flex'><div class='list-icons-item dropdown'><a href = '#' class='list-icons-item dropdown-toggle' data-bs-toggle='dropdown'><i class='fa fa-file-text'></i></a><div class='dropdown-menu dropdown-menu-end'><a href = '#' onclick='openEditModelWin(" + obj.id + ")' class='dropdown-item'><i class='fa fa-pencil'></i> Edit</a><a href = '#' class='dropdown-item' onclick='deletePOScudule(" + obj.id + ")' style='display:none'><i class='fa fa-remove'></i> Remove</a></div></div></div></td>";
                }
                else if (obj.status == "Hold")
                {
                    statusStr = "<span class='badge badge-pill badge-danger-red'>" + obj.status + "</span>";
                    actionTD = "<td class='text-center'>" +
                "<div class='list-icons d-inline-flex'>" +
                "<div class='list-icons-item dropdown'>" +
                "<div class='list-icons d-inline-flex'><a href = '#' class=' btn-sm  btn-warning list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Edit PO Sehedule'  id='btnView' onclick='openEditModelWin(" + obj.id + ")'><i class=' fa fa-pencil'></i></a><a href = '#' class=' btn-sm  btn-default list-icons-item me-10' style=' pointer-events: none' data-bs-toggle='tooltip' data-bs-original-title='Acknowledge' id='btnView' onclick='ChangeAknowlege(" + obj.id + ")'><i class=' fa fa-bell'></i></a><a href = '#' style='pointer-events: none' class=' btn-sm  btn-default list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='Hold'  id='btnView' onclick='ChangeHold(" + obj.id + ")'><i class=' fa fa-archive'></i></a></div></div></div></td>";
                }

                // TotalSKUCount = getSKUCount(obj.ponumber);
                poSchudule.Append("<tr class='poedit'><td style='display:none'>" + obj.id + "</td><td style='display:none'>" + obj.carrierid + "</td><td style='display:none'>" + obj.customerid + "</td><td>" + obj.ponumber + "</td><td>" + obj.customername + "</td><td>" + TotalSKUCount + "</td><td>" + string.Format("{0:dd-MM-yyyy}", obj.schdate) + "</td><td>" + sTime + "</td> <td>" + obj.waittime + "</td><td>" + statusStr + "</td>" + actionTD + "</tr>");
                poschdule.InnerHtml = poSchudule.ToString();
            }
        }
    }
    public List<POScheduleModel> LoadPOSchudule()
    {
        try
        {
            POScheduleModelList = new List<POScheduleModel>();
            POScheduleModel obj = new POScheduleModel();
            POScheduleModelList = obj.GetAllPOSchedules();
        }
        catch (Exception ex)
        {

        }
        return POScheduleModelList;
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


            flrdrpClient.DataSource = ddlSearchClientDT;
            flrdrpClient.DataTextField = "ClientName";
            flrdrpClient.DataValueField = "ClientID";
            flrdrpClient.DataBind();
            flrdrpClient.Items.Insert(0, new ListItem("Customer Search", String.Empty));
        }
        catch (Exception ex)
        {

        }

    }
    /// <summary>
    /// 
    /// </summary>
    protected void LoadPONumbers()
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select ponumber from po_receiving Group By ponumber", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            flterPONumber.DataSource = ddlSearchClientDT;
            flterPONumber.DataTextField = "ponumber";
            flterPONumber.DataValueField = "ponumber";
            flterPONumber.DataBind();
            flterPONumber.Items.Insert(0, new ListItem("PO Number Search", String.Empty));
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

            flrCarrier.DataSource = ddlSearchClientDT;
            flrCarrier.DataTextField = "carriername";
            flrCarrier.DataValueField = "carrierid";
            flrCarrier.DataBind();
            flrCarrier.Items.Insert(0, new ListItem("Carrier Search", String.Empty));
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
    /// <param name="ponumber"></param>
    /// <returns></returns>
    protected int getSKUCount(string ponumber)
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select  receivedquantity from po_receiving_details where ponumber='" + ponumber + "'", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            return Convert.ToInt32(ddlSearchClientDT.Rows[0][0]);
        }
        catch (Exception ex)
        {

        }
        return 0;
    }
}