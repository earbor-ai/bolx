<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master" CodeFile="POSchedule.aspx.cs" Inherits="POSchedule" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .bgred{
            background:#FF0000 !important;
        }
        .popzindex {
            z-index: 10000 !important;
        }
        .theme-primary .select2-container--default.select2-container--open {
            z-index: 10000;
        }
        .is-invalid .select2-container--default .select2-selection--single {
            border-color: #dc3545;
        }
    </style>
     
      <script src="js/jquery.min.js"></script>
  <script type="text/javascript">
      $(function () {  
            $.ajax({
                type: "POST",
                contentType: "application/json",
                data: "{}",
                url: "POSchedule.aspx/GetPONumbers",
                dataType: "json",
                success: function (data) {
            var slelectObj = $('#<%=ddlPoNumber.ClientID %>');                  
                  slelectObj.append('<option value=" ">--Select--</option>');
                    $.each(data, function (k, v) {
                        for (var i = 0; i < v.length; i++) {
                            slelectObj.append('<option value="' + v[i].clientid + '">' + v[i].ponumber + '</option>');
                        }
                        //slelectObj.append('<option value="0">Other</option>');
                    });                                           
                }
          })   
      });
     
      function SelectClient() {     
        if ($('#<%=ddlPoNumber.ClientID %>').val() == '0') {
              $('#<%=ddlClient.ClientID %>').val('');
          }
          else {
              $('#<%=ddlClient.ClientID %>').val($('#<%=ddlPoNumber.ClientID %>').val());
            $('#<%=hdnponumber.ClientID %>').val($("#<%=ddlPoNumber.ClientID %> option:selected").text());  
             $("#poerror").css("display", "none")
          }
      }
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">PO Schedule</h4>
                    <div class="d-inline-block align-items-center">
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>
                                <li class="breadcrumb-item" aria-current="page">Extra</li>
                                <li class="breadcrumb-item active" aria-current="page">Calendar</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <section class="content">
            <div class="row">
                <input type="hidden" id="hdnponumber" runat="server" />
                <div class="col-xl-12 col-lg-12 col-12">
                    	<div class="box">
					<div class="box-header with-border">						
					 <h4 class="box-title text-info mb-0"><i class="ti-calendar me-15"></i>PO Schedule Calendar</h4>   
                        <h4 class="box-title text-info mb-0"  style="width:5%"></h4>  
                         <label style="width:25px;height:15px;" class="box-primary" title="Scheduled"></label> <label class="la-sm">Scheduled</label>
                         <label style="width:25px;height:15px;" class="box-danger" title="Acknowledge"></label> <label class="la-sm">Acknowledge</label>
                           <label style="width:25px;height:15px;" class="badge-danger-red" title="Hold"></label> <label class="la-sm">Hold</label>
                          <h4 class="box-title text-info mb-0" style="width:10%"></h4>
                          <a href="#" class="btn btn-info" id="idRefresh">
                            <i class="fa fa-refresh"></i> Refresh
                        </a>
                        <a href="POScheduleDashboard.aspx" class="btn btn-primary">
                            <i class="fa fa-dashboard"></i> PO Schedule Dashboard
                        </a>
                        <a href="#" data-bs-toggle="modal" data-bs-target="#add-new-events" class="btn btn-success" id="add">
                            <i class="ti-plus"></i> Add Schedule
                        </a>
					</div>				
                        <div class="box-body">
                            <div id="calendar"></div>
                        </div>
                    </div>
                </div>     
            </div>
        </section>
    </div>
    <div class="modal fade none-border" id="add-new-events">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><strong>Add PO Schedule</strong> </h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>               
                <div class="modal-body">
                    <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="example-text-input" class="form-label">PO Number</label><span style="color: red;">*</span>                   
                                         <select class="form-control select2" id ="ddlPoNumber" name="ddlPoNumber"  data-select2-tags="true" runat="server" onchange="SelectClient()" tabindex="1"  style="width: 100%;" required="required">
                                        </select>  
                                        <span  id="poerror" style="color:red;display:none"> PO Number required</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Client</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlClient" class="form-select" runat="server" required="required" TabIndex="2"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Carrier</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlCarrier" class="form-select" runat="server" required="required" TabIndex="3"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Carrier Type</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlCarrierType" class="form-select" runat="server" required="required" TabIndex="4"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Schedule Date</label><span style="color: red;">*</span>
                                        <input id="dtSchedule" type="date" runat="server" required="required" class="form-control" tabindex="5" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Schedule Time</label><span style="color: red;">*</span>
                                        <input class="form-control" type="time" id="txtscheduleTime" required="required" runat="server" tabindex="6"  />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label ">Wait Time (Hrs)</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlWaittime" class="form-select" runat="server" required="required" TabIndex="7" >
                                            <asp:ListItem Value="">Select</asp:ListItem>
                                            <asp:ListItem Value="1 Hr">1 Hr</asp:ListItem>
                                            <asp:ListItem Value="2 Hrs">2 Hrs</asp:ListItem>
                                            <asp:ListItem Value="3 Hrs">3 Hrs</asp:ListItem>
                                            <asp:ListItem Value="4 Hrs">4 Hrs</asp:ListItem>
                                            <asp:ListItem Value="5 Hrs">5 Hrs</asp:ListItem>
                                            <asp:ListItem Value="6 Hrs">6 Hrs</asp:ListItem>
                                            <asp:ListItem Value="7 Hrs">7 Hrs</asp:ListItem>
                                            <asp:ListItem Value="8 Hrs">8 Hrs</asp:ListItem>
                                            <asp:ListItem Value="9 Hrs">9 Hrs</asp:ListItem>
                                            <asp:ListItem Value="10 Hrs">10 Hrs</asp:ListItem>
                                            <asp:ListItem Value="11 Hrs">11 Hrs</asp:ListItem>
                                            <asp:ListItem Value="12 Hrs">12 Hrs</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">No Of Pallets</label><span style="color: red;">*</span>
                                        <asp:TextBox CssClass="form-control" type="number" ID="txtnoofpallets" runat="server" required="required" TabIndex="8" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">No Of Boxes</label><span style="color: red;">*</span>

                                        <asp:TextBox CssClass="form-control" type="number" EnableViewState="false" Text="" ID="txtnoofboxes" runat="server" required="required" TabIndex="9" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Comments</label>
                                <textarea rows="3" class="form-control" placeholder="comments" id="comments" runat="server" tabindex="10"></textarea>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success save-category" OnClick="btnSave_Click" Text="Save" />
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#<%=ddlPoNumber.ClientID %>').select2();    
            
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);     
            var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
            $('#<%=dtSchedule.ClientID %>').val(today);
            $('#<%=dtSchedule.ClientID %>').attr("min", today);  
           $("#idRefresh").click(function () {
                      location.reload();
            });
            $("#add").click(function () {
                $('#<%=txtnoofboxes.ClientID %>').val('');
               $('#<%=txtnoofpallets.ClientID %>').val('');
               $('#<%=comments.ClientID %>').val('');
               $('#<%=ddlClient.ClientID %>').val('');
               $('#<%=ddlCarrier.ClientID %>').val('');
               $('#<%=ddlCarrierType.ClientID %>').val('');
               $('#<%=ddlWaittime.ClientID %>').val('');
               $('#<%=ddlPoNumber.ClientID %>').val('');
           });

        });
    </script>
</asp:Content>