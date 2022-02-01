using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
public partial class barcode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        string barCode = txtBarcode.Text;
        using (Bitmap bitMap = new Bitmap(barCode.Length * 40, 80))
        {
            using (Graphics graphics = Graphics.FromImage(bitMap))
            {
                Font oFont = new Font("IDAutomationHC39M", 16);
                PointF point = new PointF(2f, 2f);
                SolidBrush blackBrush = new SolidBrush(Color.Black);
                SolidBrush whiteBrush = new SolidBrush(Color.White);
                graphics.FillRectangle(whiteBrush, 0, 0, bitMap.Width, bitMap.Height);
                graphics.DrawString("*" + barCode + "*", oFont, blackBrush, point);
            }
            using (MemoryStream ms = new MemoryStream())
            {
                bitMap.Save(ms, ImageFormat.Png);
                imgBarcode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(ms.ToArray());
                imgBarcode.Visible = true;
            }
        }
    }
}