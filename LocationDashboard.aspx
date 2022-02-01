<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master"  CodeFile="LocationDashboard.aspx.cs" Inherits="LocationDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <script src="js/jquery.min.js"></script>
      <style>
.switch {
	position: relative;
	display: block;
	vertical-align: top;
	width: 80px;
	height: 30px;
	padding: 3px;
	margin: 0 10px 10px 0;
	background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);
	background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);
	border-radius: 18px;
	box-shadow: inset 0 -1px white, inset 0 1px 1px rgba(0, 0, 0, 0.05);
	cursor: pointer;
}
.switch-input {
	position: absolute;
	top: 0;
	left: 0;
	opacity: 0;
}
.switch-label {
	position: relative;
	display: block;
	height: inherit;
	font-size: 15px;
	text-transform: uppercase;
	background: #eceeef;
	border-radius: inherit;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
}
.switch-label:before, .switch-label:after {
	position: absolute;
	top: 50%;
	margin-top: -.5em;
	line-height: 1;
	-webkit-transition: inherit;
	-moz-transition: inherit;
	-o-transition: inherit;
	transition: inherit;
}
.switch-label:before {
	content: attr(data-off);
	right: 12px;
	color: #aaaaaa;
    font-weight:bold;
	text-shadow: 0 1px rgba(255, 255, 255, 0.5);
}
.switch-label:after {
	content: attr(data-on);
	left: 12px;
    font-weight:bold;
	color: #FFFFFF;
	text-shadow: 0 1px rgba(0, 0, 0, 0.2);
	opacity: 0;
}
.switch-input:checked ~ .switch-label {
	background: #E1B42B;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2);
}
.switch-input:checked ~ .switch-label:before {
	opacity: 0;
}
.switch-input:checked ~ .switch-label:after {
	opacity: 1;
}
.switch-handle {
	position: absolute;
	top: 4px;
	left: 4px;
	width: 28px;
	height: 28px;
	background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
	background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);
	border-radius: 100%;
	box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
}
.switch-handle:before {
	content: "";
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -6px 0 0 -6px;
	width: 12px;
	height: 12px;
	background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
	background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
	border-radius: 6px;
	box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
}
.switch-input:checked ~ .switch-handle {
	left: 50px;
	box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
}
 
/* Transition
========================== */
.switch-label, .switch-handle {
	transition: All 0.3s ease;
	-webkit-transition: All 0.3s ease;
	-moz-transition: All 0.3s ease;
	-o-transition: All 0.3s ease;
}
.table-sm > thead > tr > td, .table-sm > thead > tr > th {
  padding: 5px !important;
  vertical-align: middle;
}


.table-sm > tbody > tr > td{
    padding: 5px !important;
  vertical-align: middle;
}

.table  > tbody > tr > td{
    padding: 5px !important;
  vertical-align: middle;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">Location Dashboard</h4>
                    <div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>
								<li class="breadcrumb-item active bold" aria-current="page"><a href="WHLocation.aspx"><strong>Create Location</strong></a></li>
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
					 <h4 class="box-title text-info mb-0"><i class="ti-dashboard me-15"></i>Location Dashboard</h4>        
                        	 <h4 class="box-title text-info mb-0" style="width:65%">&nbsp;</h4>      
                          <a href="WHLocation.aspx" class="btn btn-primary">
                            <i class="fa fa-map-marker"></i> Create Location
                        </a>
					</div>
					<div class="box-body">
                        <div class="row" style="margin-bottom: -50px;">
                                  <div class="col-md-2"></div>
                          
                         
                            <div class="col-md-2" style="display:none;">
                                <div class="form-group">
 <%--                                   <label class="form-label">Location</label>--%>
                                    <asp:TextBox ID="txtLocation" class="" runat="server" AutoPostBack="true" placeholder="Location search" onblur = "OnBlur();" onkeypress="OnBlur();"></asp:TextBox>
                                    <asp:LinkButton id="lnkHidden" runat="server" OnClick="lnkHidden_Click" AutoPostBack="true" />
  
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                               <%--     <label class="form-label">Inactive</label>--%>
                                    <asp:CheckBox ID="chkInactive" Text="Inactive Locations" class="filled-in chk-col-primary" OnCheckedChanged="chkInactive_CheckedChanged" AutoPostBack="true" runat="server"></asp:CheckBox>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                             <%--       <label class="form-label">All</label>--%>
                                    <asp:CheckBox ID="chkAll" Text="All Locations" class="filled-in chk-col-primary" OnCheckedChanged="chkAll_CheckedChanged" AutoPostBack="true" runat="server"></asp:CheckBox>
                                </div>
                            </div>
                                  <div class="col-md-2"></div>
                                 <div class="col-md-2"></div>
                        </div>
                           <div class="no-padding table-responsive">
				<table id="locationtable" class="table table-bordered table-striped table-responsive">
								<thead>
									<tr>
                                        <th style="display:none">Id</th>
										<th>Location Type</th>
                                        <th>Location</th>
										<th>SKU's</th>										
                                        <th>Width</th>
                                         <th>Height</th>
                                        <th>Lemgth</th>
                                        <th>Bolx Qty</th>
                                        <th>Is Active?</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody id="locationbody" runat="server">    
								</tbody>
							</table>   
                               </div>
					</div>
				</div>
			</div>
		  </div>
		</section>
		<!-- /.content -->

        <div class="modal fade none-border" id="editposchedule">
            <div class="modal-dialog">
                <div class="modal-content" style="width:675px;">
                    <div class="modal-header">
                        <h4 class="modal-title">Warehouse Location Details</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>            
                    <div class="modal-body">
                        <table class="table table-bordered table-hover display nowrap margin-top-10 w-p100 table-sm" style="font-size:12px;padding:0px;" >
                            <thead  style="padding:0px;">
                                <tr>
                                    <th>Location Type</th>
                                    <th>Location</th>
                                    <th>Inventory Stored</th>
                                    <th>Velocity Rank</th>
                                    <th>Removal Strategy</th>
                                    <th>Putaway Strategy </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span id="locationType"></span></td>
                                    <td style="width: 225px;"><span id="location"></span></td>
                                    <td><span id="inventorystored"></span></td>
                                    <td><span id="velocityrank"></span></td>
                                    <td><span id="removalstrategy"></span></td>
                                    <td><span id="putawaystrategy"></span></td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover display nowrap margin-top-10 w-p100 table-sm"  style="font-size:12px;">
                            <thead  style="padding:0px;">
                                <tr>
                                    <th>Fill Factor</th>
                                    <th>Weight</th>
                                    <th>Weight Units</th>
                                    <th>Loc Units</th>
                                    <th>Max SKU's</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span id="fillfactor"></span></td>
                                    <td><span id="locweight"></span></td>
                                    <td><span id="locweightunits"></span></td>
                                    <td><span id="locunits"></span></td>
                                    <td><span id="locmaxskus"></span></td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover display nowrap margin-top-10 w-p100  table-sm"  style="font-size:12px;">
                            <thead  style="padding:0px;">
                                <tr>
                                    <th>Width</th>
                                    <th>Height</th>
                                    <th>Length</th>
                                    <th>Bolx Qty</th>
                                    <th>Min Bolx Qty</th>
                                    <th>Max Bolx Qty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span id="locwidthr"></span></td>
                                    <td><span id="locheight"></span></td>
                                    <td><span id="loclength"></span></td>
                                    <td><span id="bolxqty"></span></td>
                                    <td><span id="minqty"></span></td>
                                    <td><span id="maxqty"></span></td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover display nowrap margin-top-10 w-p100  table-sm"  style="font-size:12px;">
                            <thead  style="padding:0px;">
                                <tr>
                                    <th>Picking Sequence</th>
                                    <th>Pickable location</th>
                                    <th>Bin Location</th>
                                    <th>Is Lift Assist</th>
                                    <th>Is Row Restricted</th>
                                    <th>Is Scrap Location</th>
                                    <th>Is Return Location</th>                              
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><span id="pickseq"></span></td>
                                    <td><span id="picklocation"></span></td>
                                    <td><span id="isliftassist"></span></td>
                                    <td><span id="isrowrestricted"></span></td>
                                    <td><span id="isscraploc"></span></td>
                                    <td><span id="isreturnloc"></span></td>
                                    <td><span id="isbinlocation"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>                                       
                    </div>
                </div>
            </div>
        </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=txtLocation.ClientID %>').formatter({
                'pattern': 'WH01-{{99}}-{{99}}-{{99}}-{{99}}',
                'persistent': true
            });
        });
        function OnBlur() {
              $('#<%=lnkHidden.ClientID %>').click();
        }

        $('#locationtable tbody').on('click', 'input[type="checkbox"]', function (e) {
            var status = $(this).is(':checked');
            var $row = $(this).closest('tr');
            var obj = {}; obj.status = status; obj.Id = $row.find('td').eq(0).text();
            var inObj = {}; inObj.Id = $row.find('td').eq(0).text();
            var textMsg;
            if (status == true) {
                textMsg = 'Active';
            }
            else {
                textMsg = 'Inactive';
            }

             $.ajax({
                        type: "POST",
                        url: "LocationDashboard.aspx/CheckLocationHavingInventory",
                        data: JSON.stringify(inObj),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            if (result.d === 0) {
                                  $.ajax({
                                            type: "POST",
                                            url: "LocationDashboard.aspx/UpdateStatus",
                                            data: JSON.stringify(obj),
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (r) {
                                                location.reload();
                                            }
                                        });
                            }
                            else {
                                swal({
                                    title: "Are you sure to " + textMsg + " location?",
                                    text: "This location is having inventory",
                                    type: "warning",
                                    showCancelButton: true,
                                    confirmButtonColor: "#DD6B55",
                                    confirmButtonText: "Yes " + textMsg + ",  it!",
                                    closeOnConfirm: false
                                }, function (isConfirm) {
                                    if (isConfirm) {
                                        $.ajax({
                                            type: "POST",
                                            url: "LocationDashboard.aspx/UpdateStatus",
                                            data: JSON.stringify(obj),
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            success: function (r) {
                                                location.reload();
                                            }
                                        });
                                        swal("" + textMsg + "!", "Your location has been " + textMsg + "", "success");
                                    } else {
                                        location.reload();
                                    }
                                });
                            }
                        }
                    });
        });
      
        function OpenModel(val) {
             var obj = {}; obj.id = val;
            $.ajax({
                type: "POST",
                url: "LocationDashboard.aspx/GetLocationByid",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $.each(data, function (k, v) {
                        $("#locationType").html(v[0].locationtype);
                        $("#location").html(v[0].location);   
                        $("#inventorystored").html(v[0].inventorystored);  
                        $("#velocityrank").html('Rank ' + v[0].velocityrank);   
                        $("#fillfactor").html(v[0].fillfactor); 
                        $("#locweight").html(v[0].locweight); 
                        $("#locweightunits").html(v[0].locweightunits); 
                        $("#locunits").html(v[0].locunits); 
                        $("#locwidthr").html(v[0].locwidth); 
                        $("#locheight").html(v[0].locheight); 
                        $("#loclength").html(v[0].loclength); 
                        $("#locmaxskus").html(v[0].locmaxskus); 
                        $("#bolxqty").html(v[0].bolxqty); 
                        $("#minqty").html(v[0].minqty); 
                        $("#maxqty").html(v[0].maxqty); 
                        $("#removalstrategy").html(v[0].removalstrategy); 
                        $("#putawaystrategy").html(v[0].putawaystrategy); 

                        if (v[0].pickseq == true) {
                            $("#pickseq").html("Yes");
                        } else {
                              $("#pickseq").html("No");
                        }
                         if (v[0].picklocation == true) {
                            $("#picklocation").html("Yes");
                        } else {
                              $("#picklocation").html("No");
                        }
                          if (v[0].isliftassist == true) {
                            $("#isliftassist").html("Yes");
                        } else {
                              $("#isliftassist").html("No");
                        }
                        if (v[0].isrowrestricted == true) {
                            $("#isrowrestricted").html("Yes");
                        } else {
                              $("#isrowrestricted").html("No");
                        }
                          if (v[0].isscraploc == true) {
                            $("#isscraploc").html("Yes");
                        } else {
                              $("#isscraploc").html("No");
                        }
                         if (v[0].isreturnloc == true) {
                            $("#isreturnloc").html("Yes");
                        } else {
                              $("#isreturnloc").html("No");
                        }
                          if (v[0].isbinlocation == true) {
                            $("#isbinlocation").html("Yes");
                        } else {
                              $("#isbinlocation").html("No");
                        }
                    });
                }
            });
              $("#editposchedule").modal('show');
        }
      
    </script>
</asp:Content>