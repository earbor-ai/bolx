<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master" CodeFile="POScheduleDashboard.aspx.cs" Inherits="POScheduleDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script src="js/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">PO Schedule Dashboard</h4>
                 
                    <div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>
								<li class="breadcrumb-item active bold" aria-current="page"><a href="POSchedule.aspx"><strong>PO Schedule</strong></a></li>
								<li class="breadcrumb-item active" aria-current="page">Dashboard</li>                  
							</ol>
						</nav>
					</div>
                </div>              
            </div>
        </div>
        <!-- Main content -->
		<section class="content">
		  <div class="row">
			<div class="col-xl-12 col-lg-12 col-12">
				<div class="box">
					<div class="box-header with-border">						
					 <h4 class="box-title text-info mb-0"><i class="ti-dashboard me-15"></i>PO Schedule Dashboard</h4>        
                        	 <h4 class="box-title text-info mb-0" style="width:65%">&nbsp;</h4>      
                          <a href="POSchedule.aspx" class="btn btn-primary">
                            <i class="fa fa-calendar"></i> PO Schedule
                        </a>
					</div>
					<div class="box-body">						
						<div class="table-responsive">                           
                           <div class="row" style="margin-bottom:-10px; margin:0 auto;">
                             <div class="col-md-2">
                                    <div class="form-group">
                                          <label class="form-label">Carrier</label>
                                       <asp:DropDownList ID="flrCarrier" class="form-select"  runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                               <div class="col-md-2">
                                    <div class="form-group">  
                                      <label class="form-label">PO Number</label>
                                        <asp:DropDownList ID="flterPONumber" class="form-select"  runat="server"></asp:DropDownList>                         
                                    </div>
                                </div>
                              <div class="col-md-2">
                                    <div class="form-group">
                                    <label class="form-label">Customer</label>
                                   <asp:DropDownList ID="flrdrpClient" class="form-select"  runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                               <div class="col-md-2">
                                    <div class="form-group">
                                    <label class="form-label">Status</label>
                                 <select id="fddlstatus" class="form-select">
                                        <option value="">Status Search</option>
                                        <option value="Scheduled">Scheduled</option>
                                         <option value="Acknowledge">Acknowledge</option>                                   
                                        <option value="Completed">Completed</option>
                                        <option value="Hold">Hold</option>
                                    </select>
                                    </div>
                                </div>
                              <%-- <div class="col-md-4">
                                   <div class="form-group">
                                        <label class="form-label">PO Schedule Date</label>
                                       <div class="input-group input-daterange">
                                           <input type="date" id="min" class="form-control" />
                                           <span class="input-group-addon">to</span>
                                           <input type="date" id="max" class="form-control" />
                                       </div>
                                   </div>
                               </div>--%>
                        </div>
                           <div class="no-padding table-responsive">
							<table id="schtable" class="table table-bordered table-striped">
								<thead>
									<tr>
                                        <th style="display:none">ID</th>
                                         <th style="display:none">#</th>
                                        <th style="display:none">#</th>
										<th>PO Number</th>
										<th>Customer</th>
										<th>No# Sku/Count</th>
										<th>Schedule date</th>
                                        <th>Schedule time</th>
										<th>Wait Time</th>
									    <th>Status</th>
										<th class="text-center">Actions</th>
									</tr>
								</thead>
								<tbody id="poschdule" runat="server">                                  
								</tbody>
							</table>     
                          </div>
						</div>
					</div>
				</div>
			</div>
		  </div>
		</section>
		<!-- /.content -->

        <div class="modal fade none-border" id="editposchedule">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Update PO Schedule</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>            
                    <input type="hidden" id="hiddenId" name="hiddenId" />
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="form-label">PO Schedule Status</label><span style="color: red;">*</span>
                                    <select id="ddlstatus" class="form-select" required="required" onchange="EnableDisable();">
                                        <option value="">Select Status</option>
                                        <option value="Scheduled">Scheduled</option>
                                         <option value="Acknowledge">Acknowledge</option>                                   
                                        <option value="Completed">Completed</option>
                                        <option value="Hold">Hold</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="divComplete" style="display:none;">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Start Time</label><span style="color: red;">*</span>
                                        <input id="dtstartdate" name="dtstartdate"  type ="time" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">End Time</label><span style="color: red;">*</span>
                                        <input class="form-control" type="time" id="dtEnddate" name="dtEnddate"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                             <label for="example-text-input" class="form-label">No Of Persons Used</label><span style="color: red;">*</span>
                                    <input class="form-control" type="text" id="txtPalletsUsed"  name="txtPalletsUsed"/>
                                    </div>
                                </div>
                            <hr />
                            </div>
                         <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="example-text-input" class="form-label">PO Number</label><span style="color: red;">*</span>
                                    <input class="form-control"  type="text" id="ddlPoNumber" required="required" />  
                                                                
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Client</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlClient" class="form-select"  runat="server" required="required"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Carrier</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlCarrier" class="form-select" runat="server" required="required"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Carrier Type</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlCarrierType" class="form-select" runat="server" required="required"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Schedule Date</label><span style="color: red;">*</span>
                                        <%--     <asp:TextBox ID="dtSchedule" type="date" runat="server" required="required" class="form-control"></asp:TextBox>--%>
                                        <input id="dtSchedule" type="date"  required="required" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Schedule Time</label><span style="color: red;">*</span>
                                        <input class="form-control" type="time" id="txtscheduleTime" required="required"" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="form-label">Wait Time (Hrs)</label><span style="color: red;">*</span>
                                        <asp:DropDownList ID="ddlWaittime" class="form-select" runat="server" required="required">
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
                                        <input class="form-control" type="number" id="txtnoofpallets"  required="required" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">No Of Boxes</label><span style="color: red;">*</span>

                                        <input class="form-control" type="number" id="txtnoofboxes"  required="required" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Comments</label>
                                <textarea rows="3" class="form-control" placeholder="comments" id="comments" ></textarea>
                            </div>                           
                        </div>
                    </div>
                         <div class="modal-footer">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success save-category" Text="Update" OnClientClick="UpdatePOSheduleStatus();" />
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                            </div>
                    </div>                                       
                    </div>
                </div>
            </div>
        </div>

    <script type="text/javascript">
        $(document).ready(function () {
            var table = $("#schtable").DataTable();
            $('#min,#max').change(function () {
                  table.columns(4).search(this.value).draw();
                 //$('#example').dataTable().DataTable().draw();
            });
            $('#<%=flterPONumber.ClientID %>').change(function () {
                    table.columns(3).search(this.value).draw();
            });
            $('#<%=flrdrpClient.ClientID %>').change(function () {
                    table.columns(2).search(this.value).draw();
            });
              $('#<%=flrCarrier.ClientID %>').change(function () {
                    table.columns(1).search(this.value).draw();
            });
            $("#fddlstatus").change(function () {
                    table.columns(9).search(this.value).draw();
            });
        });

        function EnableDisable() {      
             //ShowHideFeildsByStatus($("#ddlstatus").val());
            if ($("#ddlstatus").val() == 'Completed') {
                $("#divComplete").show();
              $("#dtstartdate").prop("disabled", true);
            }
            else {
                $("#divComplete").hide();
                $("#dtstartdate").prop("disabled", false);
            }
        }
        function deletePOScudule(id) {
            var obj = {}; obj.id = id;
            $.ajax({
                type: "POST",
                url: "POScheduleDashboard.aspx/DeleteEvent",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    location.reload();
                }
            });
        }
        
        function UpdatePOSheduleStatus() {
            var obj = {};
            obj.id = $("#hiddenId").val();
            obj.status = $("#ddlstatus").val();
            if ($("#txtPalletsUsed").val() == '') {
                obj.noofpackets = 0;
            } else {
                obj.noofpackets = $("#txtPalletsUsed").val();
            }
            if ($("#dtstartdate").val() == '') {
                obj.starttime = "00:00";
            } else {
                obj.starttime = $("#dtstartdate").val();
            }
            if ($("#dtEnddate").val() == '') {
                obj.endtime = "00:00";
            } else {
                obj.endtime = $("#dtEnddate").val();
            }          
            obj.ponumber = $("#ddlPoNumber").val();
            obj.clientid = $('#<%=ddlClient.ClientID %>').val();
            obj.carrierid = $('#<%=ddlCarrier.ClientID %>').val();
            obj.carriertypeid = $('#<%=ddlCarrierType.ClientID %>').val();
            obj.schdate = $("#dtSchedule").val();
            obj.schtime = $("#txtscheduleTime").val();
            obj.waittime = $('#<%=ddlWaittime.ClientID %>').val();
            obj.noofboxes = $("#txtnoofboxes").val();
            obj.noofpallets = $("#txtnoofpallets").val();
            obj.comments = $("#comments").val();
         
            $.ajax({
                type: "POST",
                url: "POScheduleDashboard.aspx/UpdatePOScheduleStatus",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    location.reload();
                }
            });
        }

        function ChangeAknowlege(id) {
            var obj = {};
            obj.id = id;
            obj.status = 'Acknowledge';
             $.ajax({
                type: "POST",
                url: "POScheduleDashboard.aspx/UpdateStatusAction",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    location.reload();
                }
            });
        }
        function ChangeHold(id) {
              var obj = {};
            obj.id = id;
            obj.status = 'Hold';
             $.ajax({
                type: "POST",
                url: "POScheduleDashboard.aspx/UpdateStatusAction",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    location.reload();
                }
            });
        }


        function openEditModelWin(id) {
            $('input[id=hiddenId]').val(id);
             var obj = {}; obj.id = id;
            $.ajax({
                type: "POST",
                url: "POScheduleDashboard.aspx/POScheduleEdit",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $.each(data, function (k, v) {
                        ShowHideFeildsByStatus(v[0].status);                  
                        var postarttime = v[0].postarttime.Hours + ":" + v[0].postarttime.Minutes;
                        var poendtime = v[0].poendtime.Hours + ":" + v[0].poendtime.Minutes;
                        $("#dtstartdate").val(postarttime);
                        $("#dtEnddate").val(poendtime);
                        var schdate = v[0].schdate;
                        var value = new Date (parseInt(schdate.replace(/(^.*\()|([+-].*$)/g, '')));
                        var day = ("0" + value.getDate()).slice(-2);
                        var month = ("0" + (value.getMonth() + 1)).slice(-2);     
                        var schdate = value.getFullYear() + "-" + (month) + "-" + (day);
                       // alert(v[0].schtime.Minutes.count);
                        if (v[0].schtime.Minutes == 0 ||v[0].schtime.Minutes == 1 || v[0].schtime.Minutes == 2 || v[0].schtime.Minutes == 3
                            || v[0].schtime.Minutes == 4 || v[0].schtime.Minutes == 5 || v[0].schtime.Minutes == 6
                            || v[0].schtime.Minutes == 7 || v[0].schtime.Minutes == 8 || v[0].schtime.Minutes == 9) {
                            v[0].schtime.Minutes = "0" + v[0].schtime.Minutes;
                        }

                        var tschtime = v[0].schtime.Hours + ":" + v[0].schtime.Minutes;                       
                        $("#txtPalletsUsed").val(v[0].noofpersonsused);
                        $("#ddlstatus").val(v[0].status);
                        $("#ddlPoNumber").val(v[0].ponumber);
                        $('#<%=ddlClient.ClientID %>').val(v[0].customerid);
                        $('#<%=ddlCarrier.ClientID %>').val(v[0].carrierid);
                        $('#<%=ddlCarrierType.ClientID %>').val(v[0].carriertypeid);
                        $("#dtSchedule").val(schdate);
                        $("#txtscheduleTime").val(tschtime);
                        $('#<%=ddlWaittime.ClientID %>').val(v[0].waittime);
                        $("#txtnoofboxes").val(v[0].noofboxes);
                        $("#txtnoofpallets").val(v[0].noofpallets);
                        $("#comments").val(v[0].comments);                      
                     });
                }
            });
             $("#editposchedule").modal('show');
        }
        function ShowHideFeildsByStatus(status) {
            if (status == 'Complete' || status == 'Completed') {
                $("#divComplete").show();
                $("#ddlstatus").prop("disabled", true);
                $("#dtstartdate").prop("disabled", true);
                $("#ddlPoNumber").prop("disabled", true);
                $('#<%=ddlClient.ClientID %>').prop("disabled", true);
                $('#<%=ddlCarrier.ClientID %>').prop("disabled", true);
                $('#<%=ddlCarrierType.ClientID %>').prop("disabled", true);
                $("#dtSchedule").prop("disabled", true);
                $("#txtscheduleTime").prop("disabled", true);
            } else if (status == 'Acknowledge') {
                $("#ddlstatus option[value='Scheduled']").hide();
                $("#ddlstatus option[value='Completed']").show();
                $("#divComplete").hide()
                $("#ddlstatus").prop("disabled", false);
                $("#ddlPoNumber").prop("disabled", false);
                $('#<%=ddlClient.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrier.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrierType.ClientID %>').prop("disabled", false);
                $("#dtSchedule").prop("disabled", false);
                $("#txtscheduleTime").prop("disabled", false);

            } else if (status == 'Scheduled') {
                $("#ddlstatus option[value='Completed']").hide();
                 $("#ddlstatus option[value='Acknowledge']").show();
                $("#divComplete").hide()
                $("#ddlstatus").prop("disabled", false);
                $("#ddlPoNumber").prop("disabled", false);
                $('#<%=ddlClient.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrier.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrierType.ClientID %>').prop("disabled", false);
                $("#dtSchedule").prop("disabled", false);
                $("#txtscheduleTime").prop("disabled", false);
            }
            else {
                $("#divComplete").hide()
                $("#ddlstatus").prop("disabled", false);
                $("#ddlPoNumber").prop("disabled", false);
                $('#<%=ddlClient.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrier.ClientID %>').prop("disabled", false);
                $('#<%=ddlCarrierType.ClientID %>').prop("disabled", false);
                $("#dtSchedule").prop("disabled", false);
                $("#txtscheduleTime").prop("disabled", false);
                $("#ddlstatus option[value='Completed']").hide();
                $("#ddlstatus option[value='Scheduled']").show();
                $("#ddlstatus option[value='Acknowledge']").hide();
            }
        }

    </script>
</asp:Content>