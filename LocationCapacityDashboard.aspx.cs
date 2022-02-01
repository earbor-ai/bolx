using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LocationCapacityDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LocationModel model = new LocationModel();
        int balanceQty = 0;
        double percentage;
        string percentagetext = string.Empty;
        string percentageDiv = string.Empty;
        string switchButton = string.Empty;
        string locationstr= string.Empty;
        var result = model.GetLocationsCapacity();
        StringBuilder tableText = new StringBuilder();
        foreach (var obj in result)
        {
            locationstr = "<a href='WHLocation.aspx?locationId=" + obj.locationid+ "' style='text-decoration: underline'>" + obj.location + "</a>";
            if (obj.receivedquantity > 0)
            {
                percentage = obj.receivedquantity * 100 / obj.bolxqty;
            }
            else
            {
                percentage = 0;
            }
            percentagetext = Math.Round(percentage, 2).ToString() + "%";
            balanceQty = obj.bolxqty - obj.receivedquantity;
            percentageDiv = "<div class='progress progress-xs w-p100 mt-0'><div class='progress-bar bg-success' role='progressbar' style='width:" + percentagetext + ";' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div></div><span>" + percentagetext + "</span>";
            tableText.Append("<tr><td style='display: none'>" + obj.whid + "</td><td>" + locationstr + "</td><td>" + obj.skuname + "</td><td>" + string.Format("{0:#,0}", obj.bolxqty)  + "</td><td>" + string.Format("{0:#,0}", balanceQty)   + "</td><td>"  + percentageDiv + "</td> </tr>");
            locationbody.InnerHtml = tableText.ToString();
        }
    }
}