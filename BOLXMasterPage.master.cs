using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Configuration;
using System.Text;
using Npgsql;

public partial class BOLXMasterPage : System.Web.UI.MasterPage
{
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IntUSer"] != null)
        {
        }
        else
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void MyLnkButton_Click(Object sender, EventArgs e)
    {
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();
        NpgsqlConnection.ClearAllPools();
        Response.Redirect("Default.aspx");
    }
}
