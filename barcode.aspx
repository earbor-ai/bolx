<%@ Page Language="C#" AutoEventWireup="true" CodeFile="barcode.aspx.cs" Inherits="barcode" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:TextBox ID="txtBarcode" runat="server"></asp:TextBox>
    <asp:Button ID="btnGenerate" runat="server" Text="Generate" OnClick="btnGenerate_Click" />
    <hr />
    <asp:Image ID = "imgBarcode" runat="server" Visible = "false" />
    </form>
</body>
</html>