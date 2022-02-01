using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WHLocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string locationId = Request.QueryString["locationId"];
        if(locationId != null) {
            LocationModel _locationModel = new LocationModel();
            var result = _locationModel.GetLocationByid(Convert.ToInt32(locationId));
            foreach( var obj in result) {
                chkIsBinLocation.Disabled = true;
                htnlocationId.Value = obj.locationid.ToString();
                ddlLocationType.Value = obj.locationtype;
                aisleid.Value = _formatLocation(obj.aisle, "aisle");
                rackid.Value = _formatLocation(obj.rack, "rack");
                rowid.Value = _formatLocation(obj.row,"row");
                shelfid.Value = _formatLocation(obj.shelf, "shelf");
                binid.Value = _formatLocation(obj.bin, "bin");
                bolxid.Value= _formatLocation(obj.bolx, "bolx");
                ddlInventoryStored.Value = obj.inventorystored;
                ddlVelocityRank.Value = obj.velocityrank.ToString();
                txtFillFactor.Value = obj.fillfactor.ToString();
                txtMaxSKUs.Value=obj.locmaxskus.ToString();
                txtLocationWeight.Value = obj.locweight.ToString();
                txxtweightunits.Value = obj.locweightunits;
                txtUnits.Value = obj.locunits.ToString();
                txtBolxQty.Value = obj.bolxqty.ToString();
                txtMinBolxQty.Value= obj.minqty.ToString();
                txtMaxBolxQty.Value=obj.maxqty.ToString();
                txtWidth.Value = obj.locwidth.ToString(); 
                txtHeight.Value = obj.locheight.ToString(); 
                txtLength.Value = obj.loclength.ToString(); 
                ddlRemovelStrategy.Value = obj.removalstrategy.ToString(); 
                ddlPutAwayStrategy.Value = obj.putawaystrategy.ToString();
                barcode.Value = obj.barcode.ToString();
                qrcode.Value= obj.qrcode.ToString();
                chkPickSequence.Checked = Convert.ToBoolean(obj.pickseq);
                chkPickableLocation.Checked = Convert.ToBoolean(obj.picklocation);
                ChkIsLiftAssist.Checked = Convert.ToBoolean(obj.isliftassist);
                ChkIsRowRestricted.Checked = Convert.ToBoolean(obj.isrowrestricted);
                ChkIsScrapLocation.Checked = Convert.ToBoolean(obj.isscraploc);
                ChkReturnLocation.Checked = Convert.ToBoolean(obj.isreturnloc);
                ChkReturnLocation.Checked = Convert.ToBoolean(obj.isreturnloc);
            }
        }
    }

    [WebMethod]
    public static string SaveLocation(LocationModel _locationModel)
    {
        string result = string.Empty;
        string loctionPart = string.Empty;
        _locationModel.whid = 1;
        if(_locationModel.isbinlocation == true) {
            for(var i=1; i <= _locationModel.binrange; i++) {
                _locationModel.bin = i;
                _locationModel.location = string.Format("WH01-{0}-{1}-{2}-{3}-{4}-{5}",
                    _formatLocation(_locationModel.aisle, "aisle"), _formatLocation(_locationModel.rack, "rack"), _formatLocation(_locationModel.row, "row"), _formatLocation(_locationModel.shelf, "shelf"),
                    _formatLocation(i, "bin"), _formatLocation(_locationModel.bolx, "bolx"));
                _locationModel.barcode = _locationModel.location;
                _locationModel.qrcode = _locationModel.location;
                var recordCount = _locationModel.IsLocationExists(_locationModel.location);
                if (recordCount == 0) {
                    result = _locationModel.SaveLocation(_locationModel);               
                }
                else{
                    result = "Duplicate Location.";
                }
            }
        }
        else {
            _locationModel.location = string.Format("WH01-{0}-{1}-{2}-{3}-{4}-{5}",
                   _formatLocation(_locationModel.aisle, "aisle"), _formatLocation(_locationModel.rack, "rack"), _formatLocation(_locationModel.row, "row"), _formatLocation(_locationModel.shelf, "shelf"),
                   _formatLocation(_locationModel.bin, "bin"), _formatLocation(_locationModel.bolx, "bolx"));
            loctionPart = string.Format("WH01-{0}-{1}-{2}-{3}",
                   _formatLocation(_locationModel.aisle, "aisle"), _formatLocation(_locationModel.rack, "rack"), _formatLocation(_locationModel.row, "row"), _formatLocation(_locationModel.shelf, "shelf"));

            _locationModel.barcode = _locationModel.barcode;
            _locationModel.qrcode = _locationModel.qrcode;

            if (_locationModel.locationid > 0) {
                var recordCount = _locationModel.IsLocationExists(_locationModel.location);
                if (recordCount > 1) {
                    result = "Duplicate Location.";
                }
                else{
                    result = _locationModel.SaveLocation(_locationModel);                   
                }
            }
            else{
                var locResult = _locationModel.GetLocationsByLocationPart(loctionPart);
                if (locResult.Count > 0)
                {
                    foreach (var obj in locResult)
                    {
                        if (obj.bin > 0)
                        {
                            return "This location already exits in bin.";
                        }
                    }
                }
                var recordCount = _locationModel.IsLocationExists(_locationModel.location);
                if (recordCount == 0) {
                    result = _locationModel.SaveLocation(_locationModel);
                }
                else{
                    result = "Duplicate Location.";
                }
            }
        }
        return result;
    }

    private  static string _formatLocation(int value, string name)
    {
        string formatStr = string.Empty;
        if (name == "aisle" || name == "rack" || name == "row" || name == "bolx" || name == "shelf") {
            if (FindNumberOfDigit(value) == 1) {
                formatStr = "0" + value;
            }
            else {
                formatStr = value.ToString();
            }
        }
        else {
            if (FindNumberOfDigit(value) == 1) {
                formatStr = "00" + value;
            }
            else if (FindNumberOfDigit(value) == 2)
            {
                formatStr = "0" + value;
            }
        }
        return formatStr;
    }
    private static int FindNumberOfDigit(int number)
    {
        int count = 0;
        while (number > 0) {
            number /= 10;
            count++;
        }
        return count;
    }
}