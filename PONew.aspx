<%@ Page Title="BOLX - Dashboard" Language="C#" MasterPageFile="~/BOLXMasterPage.master" AutoEventWireup="true" CodeFile="PONew.aspx.cs" Inherits="PONew" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            // $('#modal_POUpdate').modal('show');
            setTimeout(function () {
                $('#ContentPlaceHolder1_lblErrMsg,#ContentPlaceHolder1_lblSuccMsg,#ContentPlaceHolder1_lblErrMsgNew,#ContentPlaceHolder1_lblSuccMsgNew').css("display", "none");
            }, 5000);

            $("#ContentPlaceHolder1_btnskuupc").click(function () {
                var errUpcMsg = 0;
                if ($('#ContentPlaceHolder1_txtSKUUPC').val() == "") {
                    $(".validate_txtSKUUPC").show();
                    errUpcMsg = 1;
                } else {
                    $(".validate_txtSKUUPC").hide();
                }
                if (errUpcMsg == 1) {
                    return false;
                }
            });
            $("#ContentPlaceHolder1_btnSKUSaveChanges").click(function () {
                var errMsgSKUUp = 0;
                if ($('#ContentPlaceHolder1_txtUpdBadQty').val() == "") {
                    $(".validate_txtUpdBadQty").show();
                    errMsgSKUUp = 1;
                } else {
                    $(".validate_txtUpdBadQty").hide();
                }
                if ($('#ContentPlaceHolder1_txtupdPOQty').val() == "") {
                    $(".validate_txtupdPOQty").show();
                    errMsgSKUUp = 1;
                } else {
                    $(".validate_txtupdPOQty").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdRcdQty').val() == "") {
                    $(".validate_txtUpdRcdQty").show();
                    errMsgSKUUp = 1;
                } else {
                    $(".validate_txtUpdRcdQty").hide();
                }
                if ($('#ContentPlaceHolder1_dddamagereasonUpd').val() == "NA") {
                    $(".validate_dddamagereasonUpd").show();
                    errMsgSKUUp = 1;
                } else {
                    $(".validate_dddamagereasonUpd").hide();
                }
                if (errMsgSKUUp == 1) {
                    return false;
                }
            });
            $("#ContentPlaceHolder1_btnaddsku").click(function () {
                var errMsgSKU = 0;
                if ($('#ContentPlaceHolder1_txtDamageQty').val() == "") {
                    $(".validate_txtDamageQty").show();
                    errMsgSKU = 1;
                } else {
                    $(".validate_txtDamageQty").hide();
                }
                if ($('#ContentPlaceHolder1_txtPOQty').val() == "") {
                    $(".validate_txtPOQty").show();
                    errMsgSKU = 1;
                } else {
                    $(".validate_txtPOQty").hide();
                }
                if ($('#ContentPlaceHolder1_txtRecQty').val() == "") {
                    $(".validate_txtRecQty").show();
                    errMsgSKU = 1;
                } else {
                    $(".validate_txtRecQty").hide();
                }
                if ($('#ContentPlaceHolder1_ddDamagedReason').val() == "NA") {
                    $(".validate_ddDamagedReason").show();
                    errMsgSKU = 1;
                } else {
                    $(".validate_ddDamagedReason").hide();
                }
                if (errMsgSKU == 1) {
                    return false;
                }
            });
            $("#ContentPlaceHolder1_BtnSubmit").click(function () {
                var errMsg = 0;
                if ($('#ContentPlaceHolder1_ddlSearchClient').val() == "") {
                    $(".validate_ddlSearchClient").show();
                    errMsg = 1;
                } else {
                    $(".validate_ddlSearchClient").hide();
                }
                if ($('#ContentPlaceHolder1_txtPONumber').val() == "") {
                    $(".validate_txtPONumber").show();
                    errMsg = 1;
                } else {
                    $(".validate_txtPONumber").hide();
                }
                if (errMsg == 1) {
                    return false;
                }
            });
            $("#ContentPlaceHolder1_btnSaveChanges").click(function () {
                var errMsg1 = 0;
                if ($('#ContentPlaceHolder1_dpUpdContainer').val() == "" || $('#ContentPlaceHolder1_dpUpdContainer').val() == null) {
                    $(".validate_dpUpdContainer").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_dpUpdContainer").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdPeopleCnt').val() == "") {
                    $(".validate_txtUpdPeopleCnt").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdPeopleCnt").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdTotalTime').val() == "") {
                    $(".validate_txtUpdTotalTime").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdTotalTime").hide();
                }
                if ($('#ContentPlaceHolder1_txtupdCases').val() == "") {
                    $(".validate_txtupdCases").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtupdCases").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdPallets').val() == "") {
                    $(".validate_txtUpdPallets").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdPallets").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdLabels').val() == "") {
                    $(".validate_txtUpdLabels").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdLabels").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdRcdBy').val() == "") {
                    $(".validate_txtUpdRcdBy").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdRcdBy").hide();
                }
                if ($('#ContentPlaceHolder1_txtUpdStockedBy').val() == "") {
                    $(".validate_txtUpdStockedBy").show();
                    errMsg1 = 1;
                } else {
                    $(".validate_txtUpdStockedBy").hide();
                }
                if (errMsg1 == 1) {
                    return false;
                }
            });
            $("#ContentPlaceHolder1_btnclickPOSubmit").click(function () {

                var errPOMsg1 = 0;
                if ($('#ContentPlaceHolder1_txtPO').val() == "") {
                    $(".validate_txtPO").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_txtPO").hide();
                }
                if ($('#ContentPlaceHolder1_txtASN').val() == "") {
                    $(".validate_txtASN").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_txtASN").hide();
                }
                if ($('#ContentPlaceHolder1_FloorLoaded').val() == "") {
                    $(".validate_FloorLoaded").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_FloorLoaded").hide();

                    if ($('#ContentPlaceHolder1_FloorLoaded').val() == "Yes") {
                        if ($('#ContentPlaceHolder1_dpContainer').val() == "") {
                            $(".validate_dpContainer").show();
                            errPOMsg1 = 1;
                        } else {
                            $(".validate_dpContainer").hide();
                        }
                    }
                    if ($('#ContentPlaceHolder1_FloorLoaded').val() == "No") {
                        if ($('#ContentPlaceHolder1_Palletized').val() == "") {
                            $(".validate_Palletized").show();
                            errPOMsg1 = 1;
                        } else {
                            $(".validate_Palletized").hide();
                            if ($('#ContentPlaceHolder1_Palletized').val() == "Yes") {
                                if ($('#ContentPlaceHolder1_SameSKU').val() == "") {
                                    $(".validate_SameSKU").show();
                                    errPOMsg1 = 1;
                                } else {
                                    $(".validate_SameSKU").hide();
                                }
                            }
                        }
                    }
                }
                if ($('#ContentPlaceHolder1_txtRcdBy').val() == "") {
                    $(".validate_txtRcdBy").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_txtRcdBy").hide();
                }
                if ($('#ContentPlaceHolder1_txtStockedBy').val() == "") {
                    $(".validate_txtStockedBy").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_txtStockedBy").hide();
                }
                if ($('#ContentPlaceHolder1_txtPODate').val() == "") {
                    $(".validate_txtPODate").show();
                    errPOMsg1 = 1;
                } else {
                    $(".validate_txtPODate").hide();
                }
                if (errPOMsg1 == 1) {
                    return false;
                }
            });

        });
        function showPOModal() {
            $(window).load(function () {
                $("#modal_POUpdate").modal("show");
            });
        }
        function showPOSKUModal() {
            $(window).load(function () {
                $("#modal_POSKuUpdate").modal("show");
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">PO Details</h4>
                </div>
                <asp:Label ID="lblErrMsg" runat="server" class="badge badge-lg badge-danger-red text-wrap text-start float-right" Style="width: 40%;"></asp:Label>
                <asp:Label ID="lblSuccMsg" runat="server" class="badge badge-lg bg-success text-wrap text-start float-right" Style="width: 40%;"></asp:Label>
            </div>
        </div>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-lg-12 col-12">

                    <div class="box" style="min-height: 500px;">
                        <!-- /.box-header -->
                        <div class="box-body">
                            <h4 class="box-title text-info mb-0"><i class="ti-search me-15"></i>Requirements</h4>
                            <hr class="my-15">
                            <div class="col-lg-5 m-auto">
                                <div class="row" id="form-1">
                                    <div class="col-lg-5">
                                        <div class="form-group">
                                            <label class="form-label">Client <span class="req">*</span></label>
                                            <asp:DropDownList ID="ddlSearchClient" class="form-select" runat="server"></asp:DropDownList>
                                            <span class="validate_ddlSearchClient errormsg">required field</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-5">
                                        <div class="form-group">
                                            <label class="form-label">PO Number <span class="req">*</span></label>
                                            <asp:TextBox ID="txtPONumber" class="form-control" runat="server"></asp:TextBox>
                                            <span class="validate_txtPONumber errormsg">required field</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                        <br />
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Search" class="btn btn-primary" OnClick="btnSearch_Click" Style="float: right;" />
                                    </div>
                                </div>
                            </div>

                            <%-- <button type="button" class="btn btn-primary-light btn-sm" data-bs-toggle="modal" data-bs-target="#modal_POUpdate">
                                Launch Default Modal
                            </button>--%>


                            <div id="showPOForm" runat="server" class="mt-30">
                                <h4 class="box-title text-info mb-0"><i class="ti-save me-15"></i>Add New PO</h4>
                                <hr class="my-15 mt-20">
                                <div class="col-lg-8 m-auto">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">PO Number <span class="req">*</span></label>
                                                <asp:TextBox ID="txtPO" class="form-control" runat="server"></asp:TextBox>
                                                <span class="validate_txtPO errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">Supplier ASN <span class="req">*</span></label>
                                                <asp:TextBox ID="txtASN" class="form-control" runat="server"></asp:TextBox>
                                                <span class="validate_txtASN errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">Floor Loaded? <span class="req">*</span></label>
                                                <asp:DropDownList ID="FloorLoaded" class="form-select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="myFloorLoaded_Change">
                                                    <asp:ListItem Value="">Select..</asp:ListItem>
                                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                    <asp:ListItem Value="No">No</asp:ListItem>
                                                </asp:DropDownList>
                                                <span class="validate_FloorLoaded errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="Pallet" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">Palletized? <span class="req">*</span></label>
                                                <asp:DropDownList ID="Palletized" class="form-select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="myPalletized_Change">
                                                    <asp:ListItem Value="">Select..</asp:ListItem>
                                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                    <asp:ListItem Value="No">No</asp:ListItem>
                                                </asp:DropDownList>
                                                <span class="validate_Palletized errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="SameSkus" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">Are they same SKU's? <span class="req">*</span></label>
                                                <asp:DropDownList ID="SameSKU" class="form-select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="mySameSKU_Change">
                                                    <asp:ListItem Value="">Select..</asp:ListItem>
                                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                                    <asp:ListItem Value="No">No</asp:ListItem>
                                                </asp:DropDownList>
                                                <span class="validate_SameSKU errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="TypeCon" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">Type of container <span class="req">*</span></label>
                                                <asp:DropDownList ID="dpContainer" class="form-select" runat="server"></asp:DropDownList>
                                                <span class="validate_dpContainer errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="NoofPallets" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">No of Pallets</label>
                                                <asp:TextBox ID="txtNumPallets" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="TTime" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">Total Time</label>
                                                <asp:TextBox ID="txtTotalTime" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="NoofStaff" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">No Of Staff Used</label>
                                                <asp:TextBox ID="txtPeopleCnt" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="NoofCartons" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">No of Cartons</label>
                                                <asp:TextBox ID="txtNumCartons" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="NoMixCar" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">No of Mixed Cartons</label>
                                                <asp:TextBox ID="txtMixedCartons" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4" id="SSku" runat="server">
                                            <div class="form-group">
                                                <label class="form-label">Same SKU</label>
                                                <asp:TextBox ID="txtSameSKU" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">Received By <span class="req">*</span></label>
                                                <asp:TextBox ID="txtRcdBy" class="form-control" runat="server"></asp:TextBox>
                                                <span class="validate_txtRcdBy errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">Stocked By <span class="req">*</span></label>
                                                <asp:TextBox ID="txtStockedBy" class="form-control" runat="server"></asp:TextBox>
                                                <span class="validate_txtStockedBy errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-label">PO Date <span class="req">*</span></label>
                                                <asp:TextBox ID="txtPODate" class="form-control datetime" runat="server"></asp:TextBox>
                                                <span class="validate_txtPODate errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label class="form-label">Comments</label>
                                                <asp:TextBox ID="txtComments" class="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <asp:HiddenField ID="HiddClientid" runat="server" />
                                            <asp:Button ID="btnclickPOSubmit" runat="server" Text="Add PO" class="btn btn-primary" OnClick="btnSubmit_Click" Style="float: right;" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="showPOGrid" class="mt-20" runat="server">
                                <h4 class="box-title text-info mb-0"><i class="ti-package me-15"></i>PO Info</h4>
                                <hr class="my-15">
                                <div class="no-padding table-responsive">
                                    <asp:GridView ID="gvPODetails" runat="server" AutoGenerateColumns="false" OnRowCommand="gvPODetails_RowCommand"
                                        CssClass="table table-striped table-bordered mb-0 mt-20" OnRowDataBound="gvPODetails_RowDataBound" GridLines="None">
                                        <Columns>
                                            <asp:TemplateField HeaderText="PO Number" SortExpression="" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPONumber" Text='<%# Eval("PONumber") %>' runat="server" />
                                                    <asp:LinkButton ID="LinkPO" CausesValidation="false" runat="server" CommandName="ShowPOSKUs" CommandArgument='<%#Eval("PONumber") %>' Text='<%#Eval("PONumber") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="PODate" HeaderText="PODate" />
                                            <asp:BoundField DataField="SKUCount" HeaderText="SKU Count" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="ManifestID" HeaderText="ManifestID" />
                                            <asp:BoundField DataField="POStatus" HeaderText="PO Status" />
                                            <asp:BoundField DataField="ContainerType" HeaderText="Container Type" />
                                            <asp:BoundField DataField="PeopleCnt" HeaderText="People Cnt" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="TotalTime" HeaderText="Total Time" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="NumofCases" HeaderText="Cases" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="NumOfPallets" HeaderText="Pallets" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="NumOfLabels" HeaderText="Labels" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="ReceivedBy" HeaderText="Received" />
                                            <asp:BoundField DataField="RestockBy" HeaderText="Restock" />
                                            <asp:BoundField DataField="PONumber" HeaderText="PO Number" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                            <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButtonEdit" runat="server" CommandArgument='<%#Eval("PONumber") %>'
                                                        CommandName="ShowPOPopup" CssClass="btn btn-circle btn-warning btn-xs" data-bs-toggle="tooltip" data-bs-original-title="Edit">
                                                    <i class="ti-marker-alt"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BackColor="#3f4a49" ForeColor="White" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <asp:HiddenField ID="hiddenPONo" runat="server" />


                            <div id="showPOSKUGrid" class="mt-40" runat="server">
                                <h4 class="box-title text-info mb-0"><i class="ti-server me-15"></i>PO#:
                                    <asp:Label ID="lblPONo" runat="server" />
                                    <asp:HiddenField ID="hiddPOdate" runat="server" />
                                </h4>
                                <asp:Label ID="lblSuccMsgNew" runat="server" class="badge badge-lg bg-success text-wrap text-start float-right" Style="width: 40%; float: right;"></asp:Label>
                                <asp:Label ID="lblErrMsgNew" runat="server" class="badge badge-lg badge-danger-red text-wrap text-start float-right" Style="width: 40%; float: right;"></asp:Label>
                                <hr class="my-15">

                                <div class="col-lg-3 m-auto">
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <div class="form-group">
                                                <label class="form-label">SKU / UPC <span class="req">*</span></label>
                                                <asp:TextBox ID="txtSKUUPC" class="form-control" runat="server"></asp:TextBox>
                                                <span class="validate_txtSKUUPC errormsg">required field</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <br />
                                            <asp:Button ID="btnskuupc" runat="server" Text="Search" class="btn btn-primary" OnClick="btnSkuSearch_Click" Style="float: left;" />
                                        </div>
                                    </div>
                                </div>

                                <div id="divSKUinfo" runat="server" class="mb-30">
                                    <div class="col-lg-10 m-auto">
                                        <h4 class="box-title text-info mb-0"><i class="ti-save me-15"></i>Add SKU</h4>
                                        <hr class="my-15">
                                        <div class="row">
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">PO:</label>
                                                    <asp:Label ID="lblpo" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">PO Date:</label>
                                                    <asp:Label ID="lblpodate" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">Pick Location:</label>
                                                    <asp:Label ID="lblpicklocation" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">Overstock Location:</label>
                                                    <asp:Label ID="lbloverstockloc" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">SKUID:</label>
                                                    <asp:Label ID="lblskuid" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">SKU:</label>
                                                    <asp:Label ID="lblskuname" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-label">Description:</label>
                                                    <asp:Label ID="lblskudesc" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">Damaged Quantity: <span class="req">*</span></label>
                                                    <asp:TextBox ID="txtDamageQty" class="form-control" Text="0" runat="server"></asp:TextBox>
                                                    <span class="validate_txtDamageQty errormsg">required field</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">PO Quantity: <span class="req">*</span></label>
                                                    <asp:TextBox ID="txtPOQty" class="form-control" runat="server"></asp:TextBox>
                                                    <span class="validate_txtPOQty errormsg">required field</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">Received Quantity: <span class="req">*</span></label>
                                                    <asp:TextBox ID="txtRecQty" class="form-control" Text="1" runat="server"></asp:TextBox>
                                                    <span class="validate_txtRecQty errormsg">required field</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-3">
                                                <div class="form-group">
                                                    <label class="form-label">Variance Reason: <span class="req">*</span></label>
                                                    <asp:DropDownList ID="ddDamagedReason" runat="server" class="form-select"></asp:DropDownList>
                                                    <span class="validate_ddDamagedReason errormsg">required field</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <br />
                                                <asp:Button ID="btnaddsku" runat="server" Text="Add SKU" class="btn btn-primary" OnClick="btnaddsku_Click" Style="float: right;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="no-padding table-responsive">
                                    <asp:GridView ID="GridViewData" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered display"
                                        OnRowDataBound="GridViewResults_OnRowDataBound" OnRowCommand="GridViewData_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="SKUID" HeaderText="SKUID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                            <asp:BoundField DataField="SKU" HeaderText="SKU" />
                                            <asp:BoundField DataField="Description" HeaderText="Description" />
                                            <asp:BoundField DataField="ReceivedQuantity" HeaderText="Received Qty" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="BadQty" HeaderText="Damaged Qty" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="PONumber" HeaderText="PO Number" />
                                            <asp:BoundField DataField="SKURcdDate" HeaderText="Rcd Date" />
                                            <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="center" ItemStyle-Width="120px">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButtonSkuEdit" runat="server" CommandArgument='<%#Eval("ReceivingID") %>'
                                                        CommandName="ShowSKUPopup" CssClass="btn btn-circle btn-warning btn-xs" data-bs-toggle="tooltip" data-bs-original-title="Edit" Style="margin-right: 5px;">
                                                    <i class="ti-marker-alt"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButtonRemove" runat="server" CommandArgument='<%#Eval("ReceivingID").ToString() %>'
                                                        CommandName="RemoveSKU" CssClass="btn btn-circle btn-danger btn-xs" data-bs-toggle="tooltip" data-bs-original-title="Delete" Style="margin-right: 5px;">
                                                    <i class="ti-trash"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButtonPrint" runat="server" CommandArgument='<%#Eval("ReceivingID").ToString() %>'
                                                        CommandName="PrintSKU" CssClass="btn btn-circle btn-primary btn-xs" data-bs-toggle="tooltip" data-bs-original-title="Print">
                                                    <i class="ti-printer"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="POQuantity" HeaderText="PO Qty" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="TotLotQty" HeaderText="Lot Qty" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="LotCodeCheck" HeaderText="LotCodeCheck" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                                            <asp:BoundField DataField="SKUType" HeaderText="SKU Type" ItemStyle-HorizontalAlign="left" />
                                            <asp:BoundField DataField="DamageCode" HeaderText="Damage Code" ItemStyle-HorizontalAlign="left" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.box -->
                </div>

            </div>
            <!-- /.row -->

        </section>
        <!-- /.content -->

        <!-- modal Area -->
        <div class="modal fade" id="modal_POUpdate" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document" style="max-width: 700px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">PO Details:</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="col-lg-12 col-12">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="form-label">
                                            PO Number #:
                                            <asp:Label ID="lblponumber" runat="server" />
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Container Type: <span class="req">*</span></label>
                                        <asp:DropDownList ID="dpUpdContainer" class="form-select" runat="server"></asp:DropDownList>
                                        <span class="validate_dpUpdContainer errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">People Count: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdPeopleCnt" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdPeopleCnt errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Total Time: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdTotalTime" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdTotalTime errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">No of Cases: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtupdCases" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtupdCases errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">No of Pallets: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdPallets" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdPallets errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">No of Labels: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdLabels" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdLabels errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Received By: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdRcdBy" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdRcdBy errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Stocked By: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdStockedBy" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdStockedBy errormsg">required field</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <asp:Button ID="btnSaveChanges" runat="server" Text="Save changes" class="btn btn-primary float-end" OnClick="btnSaveChanges_Click" />
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->


        <!-- modal Area -->
        <div class="modal fade" id="modal_POSKuUpdate" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document" style="max-width: 700px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">PO Details:</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="col-lg-12 col-12">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">
                                            PO Number #:
                                            <asp:Label ID="lblskuponumber" runat="server" />
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">
                                            Pick Location:
                                            <asp:Label ID="lblpickloc" runat="server" />
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="form-label">
                                            SKU:
                                            <asp:Label ID="lblsku" runat="server" />
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="form-label">
                                            Description:
                                            <asp:Label ID="lblDesc" runat="server" />
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Damaged Quantity: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdBadQty" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdBadQty errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">PO Quantity: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtupdPOQty" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtupdPOQty errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Received Quantity: <span class="req">*</span></label>
                                        <asp:TextBox ID="txtUpdRcdQty" class="form-control" runat="server"></asp:TextBox>
                                        <span class="validate_txtUpdRcdQty errormsg">required field</span>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-label">Variance Reason: <span class="req">*</span></label>
                                        <asp:DropDownList ID="dddamagereasonUpd" class="form-select" runat="server"></asp:DropDownList>
                                        <span class="validate_dddamagereasonUpd errormsg">required field</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:HiddenField ID="lblpoSKUID" runat="server" />
                        <asp:HiddenField ID="hdnUpdID" runat="server" />
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        <asp:Button ID="btnSKUSaveChanges" runat="server" Text="Save changes" class="btn btn-primary float-end" OnClick="btnSKUSaveChanges_Click" />
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

    </div>

</asp:Content>
