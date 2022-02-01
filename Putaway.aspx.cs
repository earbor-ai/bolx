using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Putaway : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
       
        lblErrMsg.Visible = false;
        lblSuccMsg.Visible = false;
        if (!IsPostBack)
        {
            LoadLocations();
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select ClientID,ClientName from whclient Order By ClientName", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlSearchClient.DataSource = ddlSearchClientDT;
            ddlSearchClient.DataTextField = "ClientName";
            ddlSearchClient.DataValueField = "ClientID";
            ddlSearchClient.DataBind();
            ddlSearchClient.Items.Insert(0, new ListItem("-- Select Client --", String.Empty));

        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        PutawayModel pusway = new PutawayModel();
        lblErrMsg.Visible = false;
        lblSuccMsg.Visible = false;
        string strQuery = "";
        if (txtPONumber.Text != "" || txtSKU.Text != "" || ddlSearchClient.SelectedIndex > 0)
        {
            if (!string.IsNullOrEmpty(txtPONumber.Text))
            {
                strQuery = " and po.ponumber ='" + txtPONumber.Text.Trim() + "'";
            }
            if (!string.IsNullOrEmpty(txtSKU.Text))
            {
                strQuery += " and sk.sku ='" + txtSKU.Text.Trim() + "'";
            }
            if (ddlSearchClient.SelectedIndex > 0)
            {
                strQuery += " and po.clientid =" + ddlSearchClient.SelectedItem.Value + "";
            }
            var result = pusway.SearchPOPutaway(strQuery);
            StringBuilder tableText = new StringBuilder();
            StringBuilder tableLocText = new StringBuilder();
            string locationstr = "";
            locationbody.InnerHtml = tableText.ToString();
            foreach (var obj in result)
            {           
                locationstr = "<button type='button' id='btnAloc' class='btn-sm btn-danger' data-bs-toggle='tooltip' data-bs-original-title='Assign Location' > <i class='ti-location-pin'></i></button>";
                tableText.Append("<tr><td class='dt-control'></td><td  style='display: none'>" + obj.skuid +"</td><td>" + obj.ponumber + "</td><td>" + obj.sku+ "</td><td>" + obj.description + "</td><td>" + obj.receivedquantity + "</td><td style='width:75px'>" + locationstr + "</td></tr>");
                locationbody.InnerHtml = tableText.ToString();
            }
            locationdiv.Visible = true;
        }
        else
        {
            lblErrMsg.Text = "Please provide any one input value before submit.";
            lblErrMsg.Visible = true;

        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="locationid"></param>
    /// <param name="skuid"></param>
    /// <param name="putwayqty"></param>
    /// <param name="ponumber"></param>
    /// <returns></returns>
    [WebMethod]
    public static bool SavePutaway(int locationid, int skuid, int putwayqty, string ponumber)
    {
        PutawayModel putawayModel = new PutawayModel();
        return putawayModel.AssignPutawayQuantity(locationid, skuid, putwayqty, ponumber);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="skuid"></param>
    /// <returns></returns>
    [WebMethod]
    public static int GetOnHandQuatityBySkuId(int skuid)
    {
        PutawayModel putawayModel = new PutawayModel();
        return putawayModel.GetOnHandQuatityBySkuId(skuid);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="skuid"></param>
    /// <returns></returns>
    [WebMethod]
    public static List<LocationDetails> GetPOlocations(int skuid)
    {
        PutawayModel putawayModel = new PutawayModel();
        return putawayModel.GetPOlocations(skuid);
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="locationId"></param>
    /// <returns></returns>
    [WebMethod]
    public static string GererateBarcode(int locationId)
    {
        PutawayModel putawayModel = new PutawayModel();
        System.Drawing.Image image;
        string imgStr = string.Empty;
        var barcode = putawayModel.GetLocationBarcode(locationId);
        PrivateFontCollection pfcoll = new PrivateFontCollection();
        pfcoll.AddFontFile(HttpContext.Current.Server.MapPath("~/barcodefonts/BarcodeFont.ttf"));
        var fontFamily = pfcoll.Families.First();
        using (Bitmap bitMap = new Bitmap(barcode.Length * 40, 80))
        {
            using (Graphics graphics = Graphics.FromImage(bitMap))
            {
                Font oFont = new Font(fontFamily,  36);
                PointF point = new PointF(2f, 2f);
                SolidBrush blackBrush = new SolidBrush(Color.Black);
                SolidBrush whiteBrush = new SolidBrush(Color.White);
                graphics.FillRectangle(whiteBrush, 0, 0, bitMap.Width, bitMap.Height);
                graphics.DrawString(barcode, oFont, blackBrush, point);
            }
            using (MemoryStream ms = new MemoryStream())
            {
                bitMap.Save(ms, ImageFormat.Jpeg);
                return "data:image/png;base64," + Convert.ToBase64String(ms.ToArray());            
            }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    protected void LoadLocations()
    {
        try
        {
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select locationid,location from whlocations where isactive = true ", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlLocation.DataSource = ddlSearchClientDT;
            ddlLocation.DataTextField = "location";
            ddlLocation.DataValueField = "locationid";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("Select Location", String.Empty));
        }
        catch (Exception ex)
        {

        }

    }

}