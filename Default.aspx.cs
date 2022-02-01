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

public partial class _Default : System.Web.UI.Page
{
    NpgsqlConnection conn = new NpgsqlConnection(ConfigurationManager.AppSettings["ConnPGSql"].ToString());
    //NpgsqlConnection conn = new NpgsqlConnection("Server=209.209.40.79;Port=19392;User Id=BOLX2021;Password=bolx@@!!;Database=BOLX;");
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LoginBtn_Click(object sender, EventArgs e)
    {
        string qry = "select userid,username, whlocationid from whusers where isactive=true and username=@UserName and whpassword=@UsrPassword";
        NpgsqlCommand cmd = new NpgsqlCommand(qry, conn);
        cmd.Parameters.AddWithValue("@UserName", txtLogin.Text.Replace("'", "''").ToString());
        cmd.Parameters.AddWithValue("@UsrPassword", txtPassword.Text.Replace("'", "''").ToString());
        conn.Open();
        NpgsqlDataReader dr1 = cmd.ExecuteReader();
        if (dr1.Read())
        {
            Session["IntUSer"] = dr1["userid"].ToString();
            Session["WHLocationId"] = dr1["whlocationid"].ToString();
            Response.Redirect("Dashboard.aspx");
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sorry, Invalid Username and Passward.')", true);
        }
        dr1.Close();
        conn.Close();
    }
}