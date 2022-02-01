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

public partial class POUpload : System.Web.UI.Page
{
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblErrMsg.Visible = false;
            lblSuccMsg.Visible = false;

            showresult.Visible = false;
            DataTable ddlSearchClientDT;
            var ddlSearchClientDA = new NpgsqlDataAdapter("select ClientID,ClientName from Client Order By ClientName", conn);
            ddlSearchClientDT = new DataTable();
            ddlSearchClientDA.Fill(ddlSearchClientDT);
            ddlSearchClient.DataSource = ddlSearchClientDT;
            ddlSearchClient.DataTextField = "ClientName";
            ddlSearchClient.DataValueField = "ClientID";
            ddlSearchClient.DataBind();
            ddlSearchClient.Items.Insert(0, new ListItem("-- Select Client --", String.Empty)); 
        }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        lblErrMsg.Visible = false;
        lblSuccMsg.Visible = false;
        int RCount = 0;
        int Cid = int.Parse(ddlSearchClient.SelectedValue);
        NpgsqlTransaction transaction = null;
        if (FileUpload1.PostedFile != null)
        {
            if (Path.GetExtension(FileUpload1.PostedFile.FileName) == ".xls" || Path.GetExtension(FileUpload1.PostedFile.FileName) == ".xlsx")
            {
                try
                {
                    conn.Open();
                    transaction = conn.BeginTransaction();
                    string number = String.Format("{0:d9}", (DateTime.Now.Ticks / 10) % 1000000000);
                    //DateTime dt = DateTime.Now;
                    DataTable dtExcel = new DataTable();

                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileUpload1.FileName);
                    //==== Get file extension.
                    string fileExtension = Path.GetExtension(FileUpload1.FileName);
                    fileNameWithoutExtension = fileNameWithoutExtension + number;

                    // string path = string.Concat(Server.MapPath("~/BOLXReceiving/" + fileNameWithoutExtension + fileExtension));
                    // string path = string.Concat(Server.MapPath(Server.MapPath(" ") + "/BOLXReceiving/" + fileNameWithoutExtension + fileExtension));
                    string path = string.Concat(Server.MapPath("BOLXReceiving/" + fileNameWithoutExtension + fileExtension));

                    FileUpload1.SaveAs(path);
                    string conString = string.Empty;
                    string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
                    switch (extension)
                    {
                        case ".xls": //Excel 97-03
                            conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                            break;
                        case ".xlsx": //Excel 07 or higher
                            conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                            break;
                    }
                    // Connection String to Excel Workbook  
                    string excelCS = string.Format(conString, path);
                    using (OleDbConnection con1 = new OleDbConnection(excelCS))
                    {
                        OleDbDataAdapter data = new OleDbDataAdapter("select * from [Sheet1$] order by 1", con1);
                        data.Fill(dtExcel);
                        StringBuilder strResult = new StringBuilder();
                        StringBuilder strPOResult = new StringBuilder();
                        String PONum = "", GlobalPO = "";
                        int TRec = 0, FRec = 0, SRec = 0, NOSKU = 0, LastRec = 0, KC1 = 0, RowCase = 0;
                        for (int i = 0; i < dtExcel.Rows.Count; i++)
                        {
                            if (dtExcel.Rows[i][1] != null)
                            {
                                if (dtExcel.Rows[i][1].ToString() != "")
                                {
                                    if (dtExcel.Rows[i][0].ToString() != PONum && dtExcel.Rows[i][0].ToString() != "" && RowCase == 0)
                                    {
                                        if (GlobalPO != "" && dtExcel.Rows[i][0].ToString() != GlobalPO && NOSKU == 0)
                                        {
                                            NpgsqlCommand cmd4 = new NpgsqlCommand("delete from tmpreceiving_po where ponumber='" + GlobalPO + "' and clientid=" + Cid, conn);
                                            cmd4.Transaction = transaction;
                                            cmd4.ExecuteNonQuery();
                                            strPOResult.Append("<tr><td>" + GlobalPO + "</td><td style='color:red;'>All SKU's Not Matched With Our Records.</td></tr>");
                                            NOSKU = 0;
                                            KC1 = 1;
                                        }
                                        else if (GlobalPO != "" && dtExcel.Rows[i][0].ToString() != GlobalPO && NOSKU == 1)
                                        {
                                            strPOResult.Append("<tr><td>" + GlobalPO + "</td><td style='color:green;'>PO Uploaded.</td></tr>");
                                            NOSKU = 0;
                                            KC1 = 1;
                                        }
                                        if (dtExcel.Rows[i][0].ToString() == GlobalPO)
                                        {
                                            KC1 = 0;
                                        }
                                        GlobalPO = dtExcel.Rows[i][0].ToString();
                                        NpgsqlCommand cmd1 = new NpgsqlCommand("select tp.ponumber,RM.ponumber from tmpreceiving_po tp full outer join receivingmaster rm on tp.ponumber = rm.ponumber where tp.ponumber='" + dtExcel.Rows[i][0].ToString() + "' or rm.ponumber='" + dtExcel.Rows[i][0].ToString() + "' and tp.clientid=" + Cid + " fetch first 1 rows only", conn);
                                        cmd1.Transaction = transaction;
                                        NpgsqlDataReader dr2 = cmd1.ExecuteReader();
                                        if (dr2.Read())
                                        {
                                            dr2.Close();
                                            strPOResult.Append("<tr><td>" + dtExcel.Rows[i][0] + "</td><td style='color:red;'>PO Already Exists. Please Add '-1' to PO Number and Try Again.</td></tr>");
                                            RowCase = 1;
                                        }
                                        else
                                        {
                                            dr2.Close();
                                            string poNumber;
                                            poNumber = dtExcel.Rows[i][0].ToString().Replace("-", "_");
                                            poNumber = dtExcel.Rows[i][0].ToString().Replace(" ", "").Trim();

                                            NpgsqlCommand cmd2 = new NpgsqlCommand("insert into tmpreceiving_po(clientid,ponumber,podate,poclosed,containertype,peoplecnt,totaltime,sent944edi,supplierasn,numofcases,numofpallets,numoflabels) values (" + Cid + ",'" + dtExcel.Rows[i][0].ToString() + "','" + DateTime.Now + "',0,'Partial Container',1,'1.00',0,'" + dtExcel.Rows[i][0].ToString() + "',1,1,1)", conn);
                                            cmd2.Transaction = transaction;
                                            cmd2.ExecuteNonQuery();
                                            PONum = dtExcel.Rows[i][0].ToString();
                                            RowCase = 0;
                                        }
                                    }
                                    if (RowCase != 1)
                                    {
                                        String SKU = dtExcel.Rows[i][1].ToString();
                                        NpgsqlCommand cmd3 = new NpgsqlCommand("select skuid from sku where sku='" + dtExcel.Rows[i][1].ToString() + "'", conn);
                                        cmd3.Transaction = transaction;
                                        NpgsqlDataReader dr1 = cmd3.ExecuteReader();
                                        if (dr1.Read())
                                        {
                                            String SID = dr1["SKUID"].ToString();
                                            dr1.Close();
                                            String ExpDateSql = "";
                                            if (dtExcel.Rows[i][3].ToString() == "")
                                            {
                                                ExpDateSql = "insert into tmpreceiving(skuid,receivedquantity,ponumber,podate,poquantity,damagecode,recexists,totalreceivedqty) values ('" + SID + "','" + dtExcel.Rows[i][2] + "','" + dtExcel.Rows[i][0] + "','" + DateTime.Now.ToString() + "','" + dtExcel.Rows[i][2] + "','NA',0,0)";

                                            }
                                            else
                                            {
                                                DateTime RDT = DateTime.Parse(dtExcel.Rows[i][3].ToString());
                                                //DateTime RDT = DateTime.ParseExact(dtExcel.Rows[i][3].ToString(), "MM/dd/yyyy hh:mm:ss tt", CultureInfo.InvariantCulture);
                                                ExpDateSql = "insert into tmpreceiving(skuid,receivedquantity,ponumber,podate,poquantity,damagecode,recexists,totalreceivedqty,expecteddate) values ('" + SID + "','" + dtExcel.Rows[i][2] + "','" + dtExcel.Rows[i][0] + "','" + DateTime.Now.ToString() + "','" + dtExcel.Rows[i][2] + "','NA',0,0,'" + RDT + "')";
                                            }
                                            NpgsqlCommand cmd4 = new NpgsqlCommand(ExpDateSql, conn);
                                            cmd4.Transaction = transaction;
                                            cmd4.ExecuteNonQuery();
                                            strResult.Append("<tr><td>" + dtExcel.Rows[i][0] + "</td><td>" + dtExcel.Rows[i][1] + "</td><td>" + dtExcel.Rows[i][2] + "</td><td style='color:green;'>SKU Added.</td></tr>");
                                            SRec++;
                                            NOSKU = 1;
                                        }
                                        else
                                        {
                                            dr1.Close();
                                            strResult.Append("<tr><td>" + dtExcel.Rows[i][0] + "</td><td>" + dtExcel.Rows[i][1] + "</td><td>" + dtExcel.Rows[i][2] + "</td><td style='color:red;'>Invalid SKU.</td></tr>");
                                            FRec++;
                                        }
                                        TRec++;
                                    }
                                }
                            }
                            RCount++;
                        }
                        if (GlobalPO != "" && NOSKU == 0 && KC1 == 1 && RowCase == 0)
                        {
                            NpgsqlCommand cmd4 = new NpgsqlCommand("delete from tmpreceiving_po where ponumber='" + GlobalPO + "' and clientid=" + Cid, conn);
                            cmd4.Transaction = transaction;
                            cmd4.ExecuteNonQuery();
                            strPOResult.Append("<tr><td>" + GlobalPO + "</td><td style='color:red;'>All SKU's Not Matched With Our Records.</td></tr>");
                            NOSKU = 0;
                        }
                        else if (GlobalPO != "" && NOSKU == 1 && KC1 == 1 && RowCase == 0)
                        {
                            strPOResult.Append("<tr><td>" + GlobalPO + "</td><td style='color:green;'>PO Uploaded.</td></tr>");
                        }
                        TRecords.Text = TRec.ToString();
                        FailedRecords.Text = FRec.ToString();
                        SuccRecords.Text = SRec.ToString();
                        transaction.Commit();
                        lblErrMsg.Visible = false;
                        lblSuccMsg.Visible = true;
                        lblSuccMsg.Text = "File uploaded.";
                        showresult.Visible = true;
                        POList.InnerHtml = strPOResult.ToString();
                        Tablelist.InnerHtml = strResult.ToString();
                    }
                }
                catch (Exception exe)
                {
                    if (transaction != null)
                    {
                        transaction.Rollback();
                    }
                    showresult.Visible = false;
                    lblSuccMsg.Visible = false;
                    lblErrMsg.Visible = true;
                    lblErrMsg.Text = "Error: File not uploaded.";
                }
                finally
                {
                    conn.Close();
                }
            }
            else
            {
                showresult.Visible = false;
                lblSuccMsg.Visible = false;
                lblErrMsg.Visible = true;
                lblErrMsg.Text = "Error: Uplaod only .xls or .xlsx format.";
            }
        }
    }
}