using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;
using System.IO;
using System.Text;
using System.Data;
using System.Configuration;
using System.Security.Cryptography;
using System.Data.OleDb;
using System.Data.Common;
using System.Globalization;
using System.Text.RegularExpressions;

public partial class PONew : System.Web.UI.Page
{
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrMsg.Visible = false;
        lblSuccMsg.Visible = false;
        lblErrMsgNew.Visible = false;
        lblSuccMsgNew.Visible = false;
        if (!IsPostBack)
        {
            showPOForm.Visible = false;
            showPOGrid.Visible = false;
            showPOSKUGrid.Visible = false;
            divSKUinfo.Visible = false;

            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select ClientID,ClientName from Client Order By ClientName", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlSearchClient.DataSource = ddlSearchClientDT;
            ddlSearchClient.DataTextField = "ClientName";
            ddlSearchClient.DataValueField = "ClientID";
            ddlSearchClient.DataBind();
            ddlSearchClient.Items.Insert(0, new ListItem("-- Select Client --", String.Empty));


            NpgsqlDataAdapter DAContainer;
            DataSet DsContainer = new DataSet();
            NpgsqlCommand cmdContainer;
            String strSQL = "select containertype from receivingcontainertype order by containertype";
            cmdContainer = new NpgsqlCommand(strSQL, conn);
            DAContainer = new NpgsqlDataAdapter(cmdContainer);
            DsContainer = new DataSet();
            DAContainer.Fill(DsContainer);
            dpContainer.DataSource = DsContainer;
            dpContainer.DataValueField = "ContainerType";
            dpContainer.DataTextField = "ContainerType";
            dpContainer.DataBind();
            dpContainer.Items.Insert(0, new ListItem("---Select---", string.Empty));

            dpUpdContainer.DataSource = DsContainer;
            dpUpdContainer.DataValueField = "ContainerType";
            dpUpdContainer.DataTextField = "ContainerType";
            dpUpdContainer.DataBind();
            dpUpdContainer.Items.Insert(0, new ListItem("---Select---", string.Empty));


            NpgsqlDataAdapter DADamagecode;
            DataSet DsDamagecode = new DataSet();
            NpgsqlCommand cmdDamagecode;
            String strSQLDam = "Select DamageCode,Description from DamageReason";
            cmdDamagecode = new NpgsqlCommand(strSQLDam, conn);
            DADamagecode = new NpgsqlDataAdapter(cmdDamagecode);
            DsDamagecode = new DataSet();
            DADamagecode.Fill(DsDamagecode);
            dddamagereasonUpd.DataSource = DsDamagecode;
            dddamagereasonUpd.DataValueField = "DamageCode";
            dddamagereasonUpd.DataTextField = "Description";
            dddamagereasonUpd.DataBind();

            ddDamagedReason.DataSource = DsDamagecode;
            ddDamagedReason.DataValueField = "DamageCode";
            ddDamagedReason.DataTextField = "Description";
            ddDamagedReason.DataBind();
            ddDamagedReason.SelectedValue = "NA";

            HideNewReq();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (conn.State == ConnectionState.Closed) { conn.Open(); }
        DataTable DT = new DataTable();
        NpgsqlCommand cmdCrearePO = new NpgsqlCommand();
        cmdCrearePO.CommandText = "usp_addpo"; // Stored Procedure to Call
        cmdCrearePO.CommandType = CommandType.StoredProcedure; // Setup Command Type
        cmdCrearePO.Connection = conn; // Active Connection

        DateTime NEWPODate = Convert.ToDateTime(txtPODate.Text);
        //DateTime NEWPODate = DateTime.Now;
        String NEWPONumber = GlobalClass.ProtectSQL(txtPO.Text);
        string SupplierASN = GlobalClass.ProtectSQL(txtASN.Text);
        bool pocheck = NEWPONumber.Contains(" ");
        if (pocheck == true)
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Error: No Spaces in PO Number";
            return;
        }
        var regexItem = new Regex("^[a-zA-Z0-9_-]*$");
        if (!regexItem.IsMatch(NEWPONumber))
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Error: No Special Characters in PO Number";
            return;
        }
        if (!regexItem.IsMatch(SupplierASN))
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "Error: No Special Characters in ASN";
            return;
        }
        String FL = FloorLoaded.SelectedValue;
        String PD = Palletized.SelectedValue;
        String SS = SameSKU.SelectedValue;
        String ContainerType = dpContainer.SelectedValue;
        int PeopleCnt;
        decimal TotalTime;
        if (txtPeopleCnt.Text != "")
        {
            PeopleCnt = Int32.Parse(GlobalClass.ProtectSQL(txtPeopleCnt.Text));
        }
        else
        {
            PeopleCnt = 1;
        }
        if (txtTotalTime.Text != "")
        {
            TotalTime = Convert.ToDecimal(GlobalClass.ProtectSQL(txtTotalTime.Text));
        }
        else
        {
            TotalTime = Convert.ToDecimal("1");
        }
        int NumCartons;
        int NumPallets;
        int NumMixedCartons;
        String NumSameSKU = "";
        if (txtNumCartons.Text == "")
        {
            NumCartons = 1;
        }
        else
        {
            NumCartons = Int32.Parse(GlobalClass.ProtectSQL(txtNumCartons.Text));
        }
        if (txtNumPallets.Text == "")
        {
            NumPallets = 1;
        }
        else
        {
            NumPallets = Int32.Parse(GlobalClass.ProtectSQL(txtNumPallets.Text));
        }
        if (txtMixedCartons.Text == "")
        {
            NumMixedCartons = 1;
        }
        else
        {
            NumMixedCartons = Int32.Parse(GlobalClass.ProtectSQL(txtMixedCartons.Text));
        }
        if (txtSameSKU.Text == "")
        {
            NumSameSKU = "1";
        }
        else
        {
            NumSameSKU = GlobalClass.ProtectSQL(txtSameSKU.Text);
        }
        String comments;
        String ReceivedBy = txtRcdBy.Text;
        String StockedBy = txtStockedBy.Text;
        if (txtComments.Text == "")
        {
            comments = "";
        }
        else
        {
            comments = GlobalClass.ProtectSQL(txtComments.Text);
        }
        String UId = Session["EntryUserID"].ToString();
        cmdCrearePO.Parameters.AddWithValue("@vponumber", NEWPONumber);
        cmdCrearePO.Parameters.AddWithValue("@vpodate", NEWPODate);
        cmdCrearePO.Parameters.AddWithValue("@vcontainertype", ContainerType);
        cmdCrearePO.Parameters.AddWithValue("@vpeoplecnt", PeopleCnt);
        cmdCrearePO.Parameters.AddWithValue("@vtotaltime", TotalTime);
        cmdCrearePO.Parameters.AddWithValue("@vsupplierasn", SupplierASN);
        cmdCrearePO.Parameters.AddWithValue("@vnumpallets", NumPallets);
        cmdCrearePO.Parameters.AddWithValue("@vreceivedby", ReceivedBy);
        cmdCrearePO.Parameters.AddWithValue("@vstockedby", StockedBy);
        cmdCrearePO.Parameters.AddWithValue("@vuserid", Int32.Parse(Session["EntryUserID"].ToString()));
        cmdCrearePO.Parameters.AddWithValue("@vcomments", comments);
        cmdCrearePO.Parameters.AddWithValue("@vfloorloaded", FL);
        cmdCrearePO.Parameters.AddWithValue("@vpalletized", PD);
        cmdCrearePO.Parameters.AddWithValue("@vissamesku", SS);
        cmdCrearePO.Parameters.AddWithValue("@vnoofcartons", NumCartons);
        cmdCrearePO.Parameters.AddWithValue("@vnomixedcartons", NumMixedCartons);
        cmdCrearePO.Parameters.AddWithValue("@vsamesku", NumSameSKU);
        cmdCrearePO.Parameters.AddWithValue("@vclientid", Int32.Parse(HiddClientid.Value));


        NpgsqlDataAdapter DAOrderCInfo = new NpgsqlDataAdapter();
        DAOrderCInfo.SelectCommand = cmdCrearePO;
        DataTable DTOrderCInfo = new DataTable();
        DAOrderCInfo.Fill(DTOrderCInfo);
        String StrResult = "";
        foreach (DataRow rowC in DTOrderCInfo.Rows)
        {
            StrResult = rowC["usp_addpo"].ToString();
        }
        //if (StrResult.Substring(0, 7) == "Success")
        //{

        //}
        //else
        //{
        //    //lblErr.Text = StrResult;
        //    return;
        //}
        if (conn.State == ConnectionState.Open) { conn.Close(); }
        GetSearchPO();
    }
    protected void myFloorLoaded_Change(object sender, EventArgs e)
    {
        if (FloorLoaded.SelectedValue == "Yes")
        {
            TypeCon.Visible = true;
            NoofPallets.Visible = true;
            TTime.Visible = true;
            NoofStaff.Visible = true;
            NoofCartons.Visible = true;
            NoMixCar.Visible = true;
            SSku.Visible = true;
            Pallet.Visible = false;
            SameSkus.Visible = false;
            Palletized.SelectedIndex = -1;
            SameSKU.SelectedIndex = -1;
            dpContainer.SelectedIndex = -1;
            txtNumPallets.Text = "";
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
        else if (FloorLoaded.Text == "No")
        {
            TypeCon.Visible = false;
            NoofPallets.Visible = false;
            TTime.Visible = false;
            NoofStaff.Visible = false;
            NoofCartons.Visible = false;
            NoMixCar.Visible = false;
            SSku.Visible = false;
            Pallet.Visible = true;
            dpContainer.SelectedIndex = -1;
            txtNumPallets.Text = "";
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
    }
    protected void myPalletized_Change(object sender, EventArgs e)
    {
        if (Palletized.SelectedValue == "No")
        {
            TTime.Visible = true;
            NoofStaff.Visible = true;
            NoofCartons.Visible = true;
            NoMixCar.Visible = true;
            SSku.Visible = true;
            SameSkus.Visible = false;
            SameSKU.SelectedIndex = -1;
            dpContainer.SelectedIndex = -1;
            txtNumPallets.Text = "";
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
        else if (Palletized.Text == "Yes")
        {
            TTime.Visible = false;
            NoofStaff.Visible = false;
            NoofCartons.Visible = false;
            NoMixCar.Visible = false;
            SSku.Visible = false;
            SameSkus.Visible = true;
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
    }
    protected void mySameSKU_Change(object sender, EventArgs e)
    {
        if (SameSKU.SelectedValue == "No")
        {
            NoofPallets.Visible = false;
            TTime.Visible = true;
            NoofStaff.Visible = true;
            NoMixCar.Visible = true;
            SSku.Visible = true;
            NoofCartons.Visible = true;
            dpContainer.SelectedIndex = -1;
            txtNumPallets.Text = "";
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
        else if (SameSKU.Text == "Yes")
        {
            NoofPallets.Visible = true;
            NoofCartons.Visible = true;
            TTime.Visible = false;
            NoofStaff.Visible = false;
            NoMixCar.Visible = false;
            SSku.Visible = false;
            dpContainer.SelectedIndex = -1;
            txtNumPallets.Text = "";
            txtTotalTime.Text = "";
            txtPeopleCnt.Text = "";
            txtNumCartons.Text = "";
            txtMixedCartons.Text = "";
            txtSameSKU.Text = "";
        }
    }
    public void HideNewReq()
    {
        TypeCon.Visible = false;
        NoofPallets.Visible = false;
        TTime.Visible = false;
        NoofStaff.Visible = false;
        NoofCartons.Visible = false;
        Pallet.Visible = false;
        SameSkus.Visible = false;
        NoMixCar.Visible = false;
        SSku.Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetSearchPO();
    }
    public void GetSearchPO()
    {
        if (conn.State == ConnectionState.Closed) { conn.Open(); }
        showPOSKUGrid.Visible = false;
        HiddClientid.Value = ddlSearchClient.SelectedValue;
        NpgsqlCommand cmdPOInfo = new NpgsqlCommand();
        cmdPOInfo.CommandText = "public.usp_searchrecent_po";
        cmdPOInfo.CommandType = CommandType.StoredProcedure;
        cmdPOInfo.Connection = conn;
        cmdPOInfo.CommandTimeout = 35;
        cmdPOInfo.Parameters.AddWithValue("@vponumber", GlobalClass.ProtectSQL(txtPONumber.Text));
        cmdPOInfo.Parameters.AddWithValue("@vclientid", Int32.Parse(GlobalClass.ProtectSQL(ddlSearchClient.SelectedValue)));
        NpgsqlDataAdapter da = new NpgsqlDataAdapter();
        da.SelectCommand = cmdPOInfo;
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "No Records Found";
            showPOForm.Visible = true;
            showPOGrid.Visible = false;
            txtPO.Text = txtPONumber.Text;
        }
        else
        {
            showPOForm.Visible = false;
            showPOGrid.Visible = true;
            gvPODetails.DataSource = dt;
            gvPODetails.DataBind();
        }

        if (conn.State == ConnectionState.Open) { conn.Close(); }
    }
    protected void gvPODetails_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView dr = (DataRowView)e.Row.DataItem;
            LinkButton hlnkView = e.Row.FindControl("LinkPO") as LinkButton;
            Label lblPO = e.Row.FindControl("lblPONumber") as Label;
            if (dr["POStatus"].ToString() == "Open")
            {
                lblPO.Visible = false;
            }
            else
            {
                hlnkView.Visible = false;
            }
        }
    }
    protected void gvPODetails_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowPOSKUs")
        {
            LinkButton btndetails = (LinkButton)e.CommandSource;
            GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;
            hiddenPONo.Value = HttpUtility.HtmlDecode(gvrow.Cells[13].Text);
            lblPONo.Text = HttpUtility.HtmlDecode(gvrow.Cells[13].Text);
            hiddPOdate.Value = HttpUtility.HtmlDecode(gvrow.Cells[1].Text);
            ContactBind_Received();
            divSKUinfo.Visible = false;
        }

        if (e.CommandName == "ShowPOPopup")
        {
            LinkButton btndetails = (LinkButton)e.CommandSource;
            GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;
            lblponumber.Text = HttpUtility.HtmlDecode(gvrow.Cells[13].Text);
            string POOrigin = gvrow.Cells[5].Text.Replace("&nbsp;", "");
            if (POOrigin != "")
            {
                dpUpdContainer.SelectedValue = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
            }
            txtUpdPeopleCnt.Text = HttpUtility.HtmlDecode(gvrow.Cells[6].Text.Replace("&nbsp;", ""));
            txtUpdTotalTime.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text.Replace("&nbsp;", ""));
            txtupdCases.Text = HttpUtility.HtmlDecode(gvrow.Cells[8].Text.Replace("&nbsp;", ""));
            txtUpdPallets.Text = HttpUtility.HtmlDecode(gvrow.Cells[9].Text.Replace("&nbsp;", ""));
            txtUpdLabels.Text = HttpUtility.HtmlDecode(gvrow.Cells[10].Text.Replace("&nbsp;", ""));
            txtUpdRcdBy.Text = HttpUtility.HtmlDecode(gvrow.Cells[11].Text.Replace("&nbsp;", ""));
            txtUpdStockedBy.Text = HttpUtility.HtmlDecode(gvrow.Cells[12].Text.Replace("&nbsp;", ""));

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showPOModal();", true);

            if (showPOSKUGrid.Visible == true)
            {
                ContactBind_Received();
            }
        }
    }

    protected void btnSkuSearch_Click(object sender, EventArgs e)
    {
        lblErrMsgNew.Visible = false;
        if (conn.State == ConnectionState.Closed) { conn.Open(); }
        string qry = "Select SKUID,SKU,description,PickLocation,OverStockLocation from SKU where SKU=@searchItem or UPCCode=@searchItem";
        NpgsqlCommand cmd = new NpgsqlCommand(qry, conn);
        cmd.Parameters.AddWithValue("@searchItem", txtSKUUPC.Text.Replace("'", "''").ToString());
        NpgsqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.Read())
        {
            lblpo.Text = lblPONo.Text.ToString();
            lblpodate.Text = hiddPOdate.Value.ToString();
            lblskuid.Text = dr1["SKUID"].ToString();
            lblskuname.Text = dr1["SKU"].ToString();
            lblskudesc.Text = dr1["description"].ToString();
            lblpicklocation.Text = dr1["PickLocation"].ToString();
            lbloverstockloc.Text = dr1["OverStockLocation"].ToString();
            divSKUinfo.Visible = true;
        }
        else
        {
            divSKUinfo.Visible = false;
            lblErrMsgNew.Visible = true;
            lblErrMsgNew.Text = "Invalid SKU/UPC";
        }
        if (conn.State == ConnectionState.Open) { conn.Close(); }
        ContactBind_Received();
    }

    protected void btnaddsku_Click(object sender, EventArgs e)
    {
        if (conn.State == ConnectionState.Closed) { conn.Open(); }

        int SKUID, RcdQty, BadQty, POQty;

        SKUID = Int32.Parse(GlobalClass.ProtectSQL(lblskuid.Text));
        RcdQty = Int32.Parse(GlobalClass.ProtectSQL(txtRecQty.Text));
        BadQty = Int32.Parse(GlobalClass.ProtectSQL(txtDamageQty.Text));
        POQty = Int32.Parse(GlobalClass.ProtectSQL(txtPOQty.Text));
        string DamageReason = ddDamagedReason.SelectedValue;
        String PONumber = lblPONo.Text;
        DateTime PODate = Convert.ToDateTime(hiddPOdate.Value);

        DataTable DT = new DataTable();
        NpgsqlCommand cmdEventUpdInfo = new NpgsqlCommand();

        cmdEventUpdInfo.CommandText = "usp_add_tmpreceiving"; // Stored Procedure to Call
        cmdEventUpdInfo.CommandType = CommandType.StoredProcedure; // Setup Command Type
        cmdEventUpdInfo.Connection = conn; // Active Connection

        cmdEventUpdInfo.Parameters.AddWithValue("@vskuid", SKUID);
        cmdEventUpdInfo.Parameters.AddWithValue("@vrcdqty", RcdQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vponumber", PONumber);
        cmdEventUpdInfo.Parameters.AddWithValue("@vpodate", PODate);
        cmdEventUpdInfo.Parameters.AddWithValue("@vbadqty", BadQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vpoqty", POQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vdamagereason", DamageReason);

        NpgsqlDataAdapter DAOrderInfo = new NpgsqlDataAdapter();
        DAOrderInfo.SelectCommand = cmdEventUpdInfo;
        DataTable DTOrderInfo = new DataTable();
        DAOrderInfo.Fill(DTOrderInfo);

        txtSKUUPC.Text = "";
        lblSuccMsgNew.Visible = true;
        lblSuccMsgNew.Text = "SKU Qty Added";

        if (conn.State == ConnectionState.Open) { conn.Close(); }

        divSKUinfo.Visible = false;
        ContactBind_Received();
    }
    protected void ContactBind_Received()
    {
        lblSuccMsg.Visible = false;
        lblErrMsg.Visible = false;
        String PONumber = hiddenPONo.Value;
        if (conn.State == ConnectionState.Closed) { conn.Open(); }

        DataTable DT = new DataTable();
        NpgsqlCommand cmdEventInfo = new NpgsqlCommand();
        cmdEventInfo.CommandText = "usp_show_tmpreceiving_bypo"; // Stored Procedure to Call
        cmdEventInfo.CommandType = CommandType.StoredProcedure; // Setup Command Type
        cmdEventInfo.Connection = conn; // Active Connection
        cmdEventInfo.Parameters.AddWithValue("@vponumber", GlobalClass.ProtectSQL(PONumber));

        NpgsqlDataAdapter DAOrderInfo = new NpgsqlDataAdapter();
        DAOrderInfo.SelectCommand = cmdEventInfo;
        DataTable DTOrderInfo = new DataTable();
        DAOrderInfo.Fill(DTOrderInfo);
        if (DTOrderInfo.Rows.Count == 0)
        {
            lblSuccMsg.Visible = false;
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "No Records Found";
        }
        else
        {
            lblErrMsg.Visible = false;
        }
        showPOSKUGrid.Visible = true;
        GridViewData.DataSource = DTOrderInfo;
        GridViewData.DataBind();

        if (conn.State == ConnectionState.Open) { conn.Close(); }
    }

    protected void GridViewResults_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.TableSection = TableRowSection.TableHeader;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int RcdQty;
            int LotQty;
            string LotCodeCheck;
            string SKU;
            SKU = e.Row.Cells[1].Text;
            RcdQty = Convert.ToInt32(e.Row.Cells[3].Text);
            LotCodeCheck = e.Row.Cells[10].Text;
            if (Regex.IsMatch(e.Row.Cells[9].Text, @"^\d+$"))
            {
                LotQty = Convert.ToInt32(e.Row.Cells[9].Text);
                if (LotCodeCheck == "1")
                {
                    if (LotQty < RcdQty)
                    {
                        e.Row.Cells[9].BackColor = System.Drawing.Color.BlanchedAlmond;
                        e.Row.Cells[9].ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }

    protected void btnSaveChanges_Click(object sender, EventArgs e)
    {
        lblSuccMsg.Visible = false;
        lblErrMsg.Visible = false;
        if (conn.State == ConnectionState.Closed) { conn.Open(); }

        DataTable DT = new DataTable();

        String UpdContainerType, StockedBy, ReceivedBy;
        int PeopleCnt, UpdNumPallets, UpdNumCases, UpdNumLabels;
        decimal TotalTime;
        UpdContainerType = dpUpdContainer.SelectedValue;
        if (txtUpdPeopleCnt.Text != "")
        {
            PeopleCnt = Int32.Parse(GlobalClass.ProtectSQL(txtUpdPeopleCnt.Text));
        }
        else
        {
            PeopleCnt = 1;
        }
        if (txtUpdTotalTime.Text != "")
        {
            TotalTime = Decimal.Parse(GlobalClass.ProtectSQL(txtUpdTotalTime.Text));
        }
        else
        {
            TotalTime = 1;
        }
        if (txtupdCases.Text == "")
        {
            UpdNumCases = 1;
        }
        else
        {
            UpdNumCases = Int32.Parse(GlobalClass.ProtectSQL(txtupdCases.Text));
        }
        if (txtUpdPallets.Text == "")
        {
            UpdNumPallets = 1;
        }
        else
        {
            UpdNumPallets = Int32.Parse(GlobalClass.ProtectSQL(txtUpdPallets.Text));
        }
        if (txtUpdLabels.Text == "")
        {
            UpdNumLabels = 1;
        }
        else
        {
            UpdNumLabels = Int32.Parse(GlobalClass.ProtectSQL(txtUpdLabels.Text));
        }
        ReceivedBy = txtUpdRcdBy.Text;
        StockedBy = txtUpdStockedBy.Text;

        NpgsqlCommand cmdChkPOExists = new NpgsqlCommand();
        cmdChkPOExists.CommandText = "usp_updatepodetails"; // Stored Procedure to Call
        cmdChkPOExists.CommandType = CommandType.StoredProcedure; // Setup Command Type
        cmdChkPOExists.Connection = conn; // Active Connection

        cmdChkPOExists.Parameters.AddWithValue("@vponumber", lblponumber.Text);
        cmdChkPOExists.Parameters.AddWithValue("@vcontainertype", UpdContainerType);
        cmdChkPOExists.Parameters.AddWithValue("@vpeoplecnt", PeopleCnt);
        cmdChkPOExists.Parameters.AddWithValue("@vtotaltime", TotalTime);
        cmdChkPOExists.Parameters.AddWithValue("@vnumcases", UpdNumCases);
        cmdChkPOExists.Parameters.AddWithValue("@vnumpallets", UpdNumPallets);
        cmdChkPOExists.Parameters.AddWithValue("@vnumlabels", UpdNumLabels);
        cmdChkPOExists.Parameters.AddWithValue("@vreceivedby", ReceivedBy);
        cmdChkPOExists.Parameters.AddWithValue("@vstockedby", StockedBy);


        NpgsqlDataAdapter DAPOInfo = new NpgsqlDataAdapter();
        DAPOInfo.SelectCommand = cmdChkPOExists;
        DataTable DTPOInfo = new DataTable();
        DAPOInfo.Fill(DTPOInfo);

        if (conn.State == ConnectionState.Open) { conn.Close(); }
        GetSearchPO();

        lblSuccMsg.Visible = true;
        lblSuccMsg.Text = "PO Updated.";
    }
    protected void GridViewData_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowSKUPopup")
        {
            int upid = Int32.Parse(e.CommandArgument.ToString());
            LinkButton btndetails = (LinkButton)e.CommandSource;
            GridViewRow gvskurow = (GridViewRow)btndetails.NamingContainer;
            lblpoSKUID.Value = HttpUtility.HtmlDecode(gvskurow.Cells[0].Text);
            lblskuponumber.Text = HttpUtility.HtmlDecode(gvskurow.Cells[5].Text);
            lblpickloc.Text = HttpUtility.HtmlDecode(gvskurow.Cells[9].Text);
            lblsku.Text = HttpUtility.HtmlDecode(gvskurow.Cells[1].Text);
            lblDesc.Text = HttpUtility.HtmlDecode(gvskurow.Cells[2].Text);
            txtupdPOQty.Text = HttpUtility.HtmlDecode(gvskurow.Cells[8].Text);
            txtUpdRcdQty.Text = HttpUtility.HtmlDecode(gvskurow.Cells[3].Text);
            txtUpdBadQty.Text = HttpUtility.HtmlDecode(gvskurow.Cells[4].Text);
            dddamagereasonUpd.SelectedValue = HttpUtility.HtmlDecode(gvskurow.Cells[12].Text);
            hdnUpdID.Value = upid.ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showPOSKUModal();", true);
        }

        if (e.CommandName == "RemoveSKU")
        {
            if (conn.State == ConnectionState.Closed) { conn.Open(); }

            NpgsqlCommand cmdDelPOSKU = new NpgsqlCommand();
            cmdDelPOSKU.CommandText = "usp_po_delete_tmpreceiving"; // Stored Procedure to Call
            cmdDelPOSKU.CommandType = CommandType.StoredProcedure; // Setup Command Type
            cmdDelPOSKU.Connection = conn; // Active Connection
            int rid = Int32.Parse(e.CommandArgument.ToString());
            cmdDelPOSKU.Parameters.AddWithValue("@vreceivingid", rid);
            NpgsqlDataAdapter DADelPOSKU = new NpgsqlDataAdapter();
            DADelPOSKU.SelectCommand = cmdDelPOSKU;
            DataTable DTDelPOSKU = new DataTable();
            DADelPOSKU.Fill(DTDelPOSKU);
            lblSuccMsgNew.Visible = true;
            lblSuccMsgNew.Text = "SKU Deleted";
            txtDamageQty.Text = "0";
            txtPOQty.Text = "";
            txtRecQty.Text = "1";
            ddDamagedReason.SelectedValue = "NA";

            if (conn.State == ConnectionState.Open) { conn.Close(); }
        }
        ContactBind_Received();
    }
    protected void btnSKUSaveChanges_Click(object sender, EventArgs e)
    {
        int SKUID = Int32.Parse(lblpoSKUID.Value);
        int RcdQty = Int32.Parse(GlobalClass.ProtectSQL(txtUpdRcdQty.Text));
        String PONumber = lblskuponumber.Text;
        int UpdRcdID = Int32.Parse(hdnUpdID.Value);
        int UpdBadQty = Int32.Parse(GlobalClass.ProtectSQL(txtUpdBadQty.Text));
        int UpdPOQty = Int32.Parse(GlobalClass.ProtectSQL(txtupdPOQty.Text));
        string DamageCode = dddamagereasonUpd.SelectedValue;

        if (conn.State == ConnectionState.Closed) { conn.Open(); }

        DataTable DT = new DataTable();
        NpgsqlCommand cmdEventUpdInfo = new NpgsqlCommand();

        cmdEventUpdInfo.CommandText = "usp_update_tmpreceiving"; // Stored Procedure to Call
        cmdEventUpdInfo.CommandType = CommandType.StoredProcedure; // Setup Command Type
        cmdEventUpdInfo.Connection = conn; // Active Connection

        cmdEventUpdInfo.Parameters.AddWithValue("@vupdrcdid", UpdRcdID);
        cmdEventUpdInfo.Parameters.AddWithValue("@vrcdqty", RcdQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vbadqty", UpdBadQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vpoqty", UpdPOQty);
        cmdEventUpdInfo.Parameters.AddWithValue("@vdamagecode", DamageCode);

        NpgsqlDataAdapter DAOrderInfo = new NpgsqlDataAdapter();
        DAOrderInfo.SelectCommand = cmdEventUpdInfo;
        DataTable DTOrderInfo = new DataTable();
        DAOrderInfo.Fill(DTOrderInfo);

        lblSuccMsgNew.Visible = true;
        lblSuccMsgNew.Text = "SKU Qty Updated";

        if (conn.State == ConnectionState.Open) { conn.Close(); }

        ContactBind_Received();
    }
}