using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LocationDashboard : System.Web.UI.Page
{
    LocationModel _locationModel = new LocationModel();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var result = _locationModel.GetLocations();
            LoadDashboardData(result.Where(m =>m.isactive == true).ToList());    
        }
    }

    [WebMethod]
    public static List<LocationModel> GetLocationByid(int id)
    {
        LocationModel obj = new LocationModel();
        return obj.GetLocationByid(id);
    }
    [WebMethod]
    public static bool UpdateStatus(bool status, int Id)
    {
        LocationModel obj = new LocationModel();
        return obj.UpdateStatus(status,Id);
    }

    [WebMethod]
    public static int CheckLocationHavingInventory(int Id)
    {
        LocationModel obj = new LocationModel();
        return obj.IsLocationInventory(Id);
    }

    private void LoadDashboardData(List<LocationModel> model)
    {
        StringBuilder tableText = new StringBuilder();
        locationbody.InnerHtml = string.Empty;
        foreach (var obj in model)
        {

            string switchButton = string.Empty;

            if (obj.isactive)
            {
                switchButton = "<label class='switch'> <input class='switch-input' type='checkbox'  checked='checked'  id='chkPickSequence'/> <span class='switch-label' data-on='Yes' data-off='No'></span> <span class='switch-handle'></span></label>";
            }
            else
            {
                switchButton = "<label class='switch'> <input class='switch-input' type='checkbox'  id='chkPickSequence'/> <span class='switch-label' data-on='Yes' data-off='No'></span> <span class='switch-handle'></span></label>";
            }
            string actionDiv = "<td class='text-center'><div class='list-icons d-inline-flex'><a href = '#' class=' btn-sm  btn-primary list-icons-item me-10' data-bs-toggle='tooltip' data-bs-original-title='View Location Full Details'  id='btnView' onclick='OpenModel(" + obj.locationid + ")'><i class=' fa fa-eye-slash'></i></a>&nbsp; <a href = 'WHLocation.aspx?locationId=" + obj.locationid + "' class=' btn-sm  btn-danger list-icons-item me-10'  data-bs-toggle='tooltip' data-bs-original-title='Edit Location Details' ><i class='fa fa-pencil'></i></a></div></td>";
            tableText.Append("<tr><td style='display:none'>" + obj.locationid + "</td><td>" + obj.locationtype + "</td><td>" + obj.location + "</td><td>" + obj.locmaxskus + "</td><td>" + obj.locwidth + "</td><td>" + obj.locheight + "</td ><td>" + obj.loclength + "</td ><td>" + obj.bolxqty + "</td ><td>" + switchButton + "</td>" + actionDiv + " </tr>");
            locationbody.InnerHtml = tableText.ToString();
        }

    }

    protected void chkInactive_CheckedChanged(object sender, EventArgs e)
    {
        var result = _locationModel.GetLocations();
        if (chkInactive.Checked == true)
        {
            LoadDashboardData(result.Where(m => m.isactive == false).ToList());
        }
        else
        {
            LoadDashboardData(result.Where(m => m.isactive == true).ToList());
        }

    }

    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        var result = _locationModel.GetLocations();
        if (chkAll.Checked == true)
        {    
            LoadDashboardData(result);
        }
        else
        {
            LoadDashboardData(result.Where(m => m.isactive == true).ToList());
        }      
    }

    protected void lnkHidden_Click(object sender, EventArgs e)
    {
        if (txtLocation.Text != "" || txtLocation.Text != null)
        {
            var result = _locationModel.GetLocationsByLocationPart(txtLocation.Text);
            LoadDashboardData(result);
        }
    }
}