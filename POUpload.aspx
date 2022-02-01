<%@ Page Title="BOLX - Inward PO - PO Upload" Language="C#" MasterPageFile="~/BOLXMasterPage.master" AutoEventWireup="true" CodeFile="POUpload.aspx.cs" Inherits="POUpload" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">PO Upload</h4>
                </div>
                <asp:Label id="lblErrMsg" runat="server" class="badge badge-lg badge-danger-red text-wrap text-start float-right" style="width:40%;"></asp:Label>
                <asp:Label id="lblSuccMsg" runat="server" class="badge badge-lg bg-success text-wrap text-start float-right" style="width:40%;"></asp:Label>
            </div>
        </div>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-lg-12 col-12">
                    
                    <div class="box" style="min-height: 500px;">
                        <!-- /.box-header -->
                        <div class="box-body">
                            <h4 class="box-title text-info mb-0"><i class="ti-save me-15"></i>Requirements</h4>
                            <hr class="my-15">
                            <div class="col-lg-4 m-auto">                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Client <span class="req">*</span></label>
                                            <asp:DropDownList ID="ddlSearchClient" class="form-select" runat="server" required ></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-label">Upload Excel <span class="req">*</span></label><br />
                                            <label class="form" style="width:100%;">
                                                <asp:FileUpload ID="FileUpload1" class="form-control" runat="server" style="width:100%;" required />
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Save" class="btn btn-primary" OnClick="btnUpload_Click" Style="float: right;" />
                                    </div>
                                </div>
                            </div>

                            <div id="showresult" runat="server">
                                <table style="margin-top: 15px; width: 600px; text-align: center; margin: 15px auto;">
                                    <tr>
                                        <td>Total Records Uploaded: <b>
                                            <asp:Label ID="TRecords" runat="server" Text="0" /></b></td>
                                        <td>Total Success Records: <b>
                                            <asp:Label ID="SuccRecords" runat="server" Text="0" /></b></td>
                                        <td>Total Failed Records: <b>
                                            <asp:Label ID="FailedRecords" runat="server" Text="0" /></b></td>
                                    </tr>
                                </table>
                                <table class="table table-striped" style="margin-top: 15px; width: 600px; text-align: center; margin: 15px auto;">
                                    <thead>
                                        <tr style="background-color: #3f4a49;color: #ffffff;" class="LabelTxtWhite">
                                            <th scope="col" style="text-align: center;">PO</th>
                                            <th scope="col" style="text-align: center;">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="POList" runat="server"></tbody>
                                </table>
                                <table class="table table-striped" style="margin-top: 15px; width: 600px; text-align: center; margin: 15px auto;">
                                    <thead>
                                        <tr style="background-color: #3f4a49;color: #ffffff;" class="LabelTxtWhite">
                                            <th scope="col" style="text-align: center;">PO</th>
                                            <th scope="col" style="text-align: center;">SKU</th>
                                            <th scope="col" style="text-align: center;">Qty</th>
                                            <th scope="col" style="text-align: center;">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="Tablelist" runat="server"></tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                    <!-- /.box -->
                </div>

            </div>
            <!-- /.row -->

        </section>
        <!-- /.content -->
    </div>
</asp:Content>

