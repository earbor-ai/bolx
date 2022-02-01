<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master" CodeFile="WHLocation.aspx.cs" Inherits="WHLocation" %>
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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">Warehouse Location</h4>
                    <div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>                             
								<li class="breadcrumb-item active bold" aria-current="page"><a href="#px"><strong>Create Location</strong></a></li>              
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
                            <h4 class="box-title text-info mb-0"><i class="ti-location-pin me-15"></i>Create Location</h4>
                              	 <h4 class="box-title text-info mb-0" style="width:50%">&nbsp;</h4>    
                            <a href="LocationCapacityDashboard.aspx" class="btn btn-danger float-right">
                                <i class="fa fa-dashboard"></i> Capacity Dashboard
                            </a>
                            <a href="LocationDashboard.aspx" class="btn btn-primary float-right">
                                <i class="fa fa-dashboard"></i> Location Dashboard
                            </a>
                        </div>
                        <div class="box-body wizard-content">
                            <form  action="#" class="validation-wizard wizard-circle" method="post">
                                <!-- Step 1 -->
                                <h6>Location Info</h6>
                                <section>
                                    <input id="htnlocationId" type="hidden" runat="server" value="0" />
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Location Type</label><span style="color: red">*</span>
                                                <select id="ddlLocationType" runat="server" class="form-select" required="required" tabindex="2">
                                                    <option value="">Select Location</option>
                                                    <option value="Primary">Primary</option>
                                                    <option value="Secondary">Secondary</option>
                                                    <option value="Bulk">Bulk</option>
                                                    <option value="Temporary">Temporary</option>
                                                    <option value="Defective">Defective</option>
                                                    <option value="Return to Vendor">Return to Vendor</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Aisle</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="aisleid" required="required" runat="server" onkeydown="if(this.value.length==2 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Rack</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="rackid" required="required" runat="server" onkeydown="if(this.value.length==2 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Row</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="rowid" required="required" runat="server" onkeydown="if(this.value.length==2 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Shelf</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="shelfid" required="required" runat="server" onkeydown="if(this.value.length==2 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Bin</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="binid" required="required" runat="server" onkeydown="if(this.value.length==3 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                        <div class="col-md-1">
                                            <div class="form-group">
                                                <label class="form-label">Bolx</label>
                                                <input class="form-control" type="number" id="bolxid" runat="server" onkeydown="if(this.value.length==2 && event.keyCode!=8) return false;" onchange="SetBarQRValue(this.value)" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Inventory Stored</label><span style="color: red">*</span>
                                                <select id="ddlInventoryStored" runat="server" class="form-select" required="required" tabindex="3">
                                                    <option value="">Select Inventory Stored</option>
                                                    <option value="Hang">Hang</option>
                                                    <option value="Flat">Flat</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Velocity Rank</label>
                                                <select id="ddlVelocityRank" runat="server" class="form-select" tabindex="5">
                                                    <option value="">Select Velocity Rank</option>
                                                    <option value="1">Rank 1</option>
                                                    <option value="2">Rank 2</option>
                                                    <option value="3">Rank 3</option>
                                                    <option value="4">Rank 4</option>
                                                    <option value="5">Rank 5</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Fill Factor</label><span style="color: red">*</span>
<%--                                                <input class="form-control" type="number" id="txtFillFactor" required="required" runat="server" onkeydown="if(this.value.length==6 && event.keyCode!=8) return false;" />--%>
                 <input id="txtFillFactor" type="number" value="55" name="txtFillFactor"  required="required" runat="server"  onkeydown="if(this.value.length==6 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Max SKUs</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="txtMaxSKUs" runat="server" required="required" onkeydown="if(this.value.length==3 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <label class="form-label">Picking Sequence</label>
                                            <label class="switch">
                                                <input class="switch-input" type="checkbox" id="chkPickSequence" runat="server" tabindex="4" />
                                                <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="example-text-input" class="form-label">Pickable location</label>
                                            <label class="switch">
                                                <input class="switch-input" type="checkbox" id="chkPickableLocation" runat="server" tabindex="17" />
                                                <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="example-text-input" class="form-label">Is Bin Location</label>
                                            <label class="switch">
                                                <input class="switch-input" type="checkbox" id="chkIsBinLocation" runat="server"  tabindex="17" />
                                                <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>

                                        <div class="col-md-2" id="binRangeid" style="display: none">
                                            <label for="calc-bin" id="calc-bin_value">Bin Range: 2</label>
                                            <input id="calc-bin" type="range" value="1" min="1" max="50" />
                                        </div>
                                    </div>
                                </section>
                                <!-- Step 2 -->
                                <h6>Location Capacity</h6>
                                <section>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="example-text-input" class="form-label">Location Weight</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="txtLocationWeight" runat="server" name="txtLocationWeight" required="required" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="example-text-input" class="form-label">Location Weight Units</label><span style="color: red">*</span>
                                                <input class="form-control" type="text" id="txxtweightunits" runat="server" name="txtLocationWeight" required="required" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="example-text-input" class="form-label">Location Units</label><span style="color: red">*</span>
                                            <input class="form-control" type="number" id="txtUnits" runat="server" required="required" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-2">
                                            <label for="example-text-input" class="form-label">Bolx Qty</label><span style="color: red">*</span>
                                            <input class="form-control" type="number" runat="server" id="txtBolxQty" required="required" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Min Bolx Qty</label>
                                                <input class="form-control" type="number" id="txtMinBolxQty" runat="server" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Max Bolx Qty</label>
                                                <input class="form-control" type="number" id="txtMaxBolxQty" runat="server" onkeydown="if(this.value.length==10 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>

                                    </div>
                                </section>
                                <!-- Step 3 -->
                                <h6>Dimensions & Strategy</h6>
                                <section>
                                    <div class="row">
                                        <div class="col-md-2">
                                             <div class="form-group">
                                            <label for="example-text-input" class="form-label">Width</label><span style="color: red">*</span>
                                            <input class="form-control" type="number" id="txtWidth" runat="server" required="required" onkeydown="if(this.value.length==6 && event.keyCode!=8) return false;" />
                                        </div> </div>
                                        <div class="col-md-2">
                                              <div class="form-group">
                                            <label for="example-text-input" class="form-label">Height</label><span style="color: red">*</span>
                                            <input class="form-control" type="number" id="txtHeight" runat="server" required="required" onkeydown="if(this.value.length==6 && event.keyCode!=8) return false;" />
                                        </div></div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label for="example-text-input" class="form-label">Length</label><span style="color: red">*</span>
                                                <input class="form-control" type="number" id="txtLength" runat="server" required="required" onkeydown="if(this.value.length==6 && event.keyCode!=8) return false;" />
                                            </div>
                                        </div>
                                    </div>
                           
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="form-label">Removal Strategy</label>
                                                <span style="color: red">*</span>
                                                <select id="ddlRemovelStrategy" runat="server" class="form-select" required="required" tabindex="5">
                                                    <option value="">Select Removal Strategy</option>
                                                    <option value="FIFO">FIFO</option>
                                                    <option value="LIFO">LIFO</option>
                                                    <option value="FEFO">FEFO</option>
                                                    <option value="FLFO">FLFO</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="form-label">Put Away Strategy</label>
                                                <span style="color: red">*</span>
                                                <select id="ddlPutAwayStrategy" runat="server" class="form-select" required="required" tabindex="5">
                                                    <option value="">Select Put Away Strategy</option>
                                                    <option value="Direct putaway">Direct putaway</option>
                                                    <option value="Indirect">Indirect</option>
                                                    <option value="Fixed location">Fixed location</option>
                                                    <option value="Dynamic location">Dynamic location</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <!-- Step 4 -->
                                <h6>Other Info</h6>
                                <section>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="form-label">Bar Code</label><span style="color: red">*</span>
                                                <small class="sidetitle">E.g: (WH00-00-00-00-000-00)</small>
                                                <input type="text" class="form-control" id="barcode" runat="server" tabindex="19" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="form-label">QR Code</label>
                                                <small class="sidetitle">E.g: (WH00-00-00-00-000-00)</small>
                                                <input type="text" class="form-control" id="qrcode" runat="server" tabindex="20" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <label for="example-text-input" class="form-label">Is Lift Assist</label>
                                            <label class="switch">
                                                <input class="switch-input" type="checkbox" runat="server" id="ChkIsLiftAssist"  tabindex="13" />
                                                <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                <span class="switch-handle"></span>
                                            </label>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Is Row Restricted</label>
                                                <label class="switch">
                                                    <input class="switch-input" type="checkbox" runat="server" id="ChkIsRowRestricted" tabindex="14" />
                                                    <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                    <span class="switch-handle"></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Is Scrap Location</label>
                                                <label class="switch">
                                                    <input class="switch-input" type="checkbox" runat="server" id="ChkIsScrapLocation" tabindex="15" />
                                                    <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                    <span class="switch-handle"></span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="form-label">Is Return Location</label>
                                                <label class="switch">
                                                    <input class="switch-input" type="checkbox" runat="server" id="ChkReturnLocation" tabindex="16" />
                                                    <span class="switch-label" data-on="Yes" data-off="No"></span>
                                                    <span class="switch-handle"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                          
                                </section>
                            
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        </div>
   
  <script type="text/javascript">
      function SetBarQRValue() {
          var aisleid = $('#<%=aisleid.ClientID %>').val();
          if (aisleid.length === 1) {
              aisleid = "0" + aisleid;
          }
          var rowid = $('#<%=rowid.ClientID %>').val();
  
          if (rowid.length === 1) {
              rowid = "0" + rowid;
          }
           var rackid = $('#<%=rackid.ClientID %>').val();
          if (rackid.length === 1) {
              rackid = "0" + rackid;
          }
           var rowid = $('#<%=rowid.ClientID %>').val();
          if (rowid.length === 1) {
              rowid = "0" + rowid;
          }
          var binid = $('#<%=binid.ClientID %>').val();
          if (binid.length === 1) {
              binid = "00" + binid;
          }
          else if (binid.length === 2) {
              binid = "0" + binid;
          }
          var bolxid = $('#<%=bolxid.ClientID %>').val();
          if (bolxid.length === 0) {
              bolxid = "00" + bolxid;
          } else if (bolxid.length === 1) {
              bolxid = "0" + bolxid;
          }
          $('#<%=barcode.ClientID %>').val('WH01-' + aisleid + '-' + rackid + '-' +rowid + '-' + binid + '-' + bolxid);
          $('#<%=qrcode.ClientID %>').val('WH01-' + aisleid + '-' + rowid + '-' +rowid + '-' + binid + '-' + bolxid);
      }
      $(function () {
          $('#<%=qrcode.ClientID %>, #<%=barcode.ClientID %>').formatter({
            'pattern': 'WH01-{{99}}-{{99}}-{{99}}-{{99}}-{{999}}-{{99}}',
            'persistent': true
        });
      });

      $(function () {
         $('#<%=txtFillFactor.ClientID %>').TouchSpin({
              min: 0,
              max: 100,
              step: 0.1,
              decimals: 2,
              boostat: 5,
              maxboostedstep: 10,
              postfix: '%'
          });
      });
      $(document).ready(function () {

        
          var form = $(".validation-wizard").show();
          $(".validation-wizard").steps({
              headerTag: "h6"
              , bodyTag: "section"
              , transitionEffect: "none"
              , titleTemplate: '<span class="step">#index#</span> #title#'
              , labels: { finish: "Submit" }
              , onStepChanging: function (event, currentIndex, newIndex) {
                  return currentIndex > newIndex || !(3 === newIndex && Number($("#age-2").val()) < 18) && (currentIndex < newIndex && (form.find(".body:eq(" + newIndex + ") label.error").remove(), form.find(".body:eq(" + newIndex + ") .error").removeClass("error")), form.validate().settings.ignore = ":disabled,:hidden", form.valid())
              }
              , onStepChanged: function (event, currentIndex, newIndex) {}
              , onFinishing: function (event, currentIndex) { return form.validate().settings.ignore = ":disabled", form.valid() }
              , onFinished: function (event, currentIndex) {
                  var _locationModel = {}
                  _locationModel.locationid = $('#<%=htnlocationId.ClientID %>').val();
                  _locationModel.locationtype = $('#<%=ddlLocationType.ClientID %>').val();
                  _locationModel.aisle = $('#<%=aisleid.ClientID %>').val();
                  _locationModel.rack = $('#<%=rackid.ClientID %>').val();
                  _locationModel.row = $('#<%=rowid.ClientID %>').val();
                  _locationModel.shelf = $('#<%=shelfid.ClientID %>').val();

                  if ($('#<%=binid.ClientID %>').val() == '' || $('#<%=binid.ClientID %>').val() == null){
                      $('#<%=binid.ClientID %>').val('0');
                  }
                  _locationModel.bin = $('#<%=binid.ClientID %>').val();
                  
                  if ($('#<%=bolxid.ClientID %>').val() == '' || $('#<%=bolxid.ClientID %>').val() == null) {
                      $('#<%=bolxid.ClientID %>').val('0');
                  }
                  _locationModel.bolx = $('#<%=bolxid.ClientID %>').val();
                  _locationModel.inventorystored = $('#<%=ddlInventoryStored.ClientID %>').val();
                  _locationModel.fillfactor = $('#<%=txtFillFactor.ClientID %>').val();
                  _locationModel.velocityrank = $('#<%=ddlVelocityRank.ClientID %>').val();
                  _locationModel.locweight = $('#<%=txtLocationWeight.ClientID %>').val();
                  _locationModel.locweightunits = $('#<%=txxtweightunits.ClientID %>').val();
                  _locationModel.locunits = $('#<%=txtUnits.ClientID %>').val();
                  _locationModel.locwidth = $('#<%=txtWidth.ClientID %>').val();
                  _locationModel.locheight = $('#<%=txtHeight.ClientID %>').val();
                  _locationModel.loclength = $('#<%=txtLength.ClientID %>').val();
                  _locationModel.locmaxskus = $('#<%=txtMaxSKUs.ClientID %>').val();
                  _locationModel.bolxqty = $('#<%=txtBolxQty.ClientID %>').val();
                   if ($('#<%=txtMinBolxQty.ClientID %>').val() == '' || $('#<%=txtMinBolxQty.ClientID %>').val() == null) {
                      $('#<%=txtMinBolxQty.ClientID %>').val('0');
                  }
                  _locationModel.minqty = $('#<%=txtMinBolxQty.ClientID %>').val();
                    if ($('#<%=txtMaxBolxQty.ClientID %>').val() == '' || $('#<%=txtMaxBolxQty.ClientID %>').val() == null) {
                      $('#<%=txtMaxBolxQty.ClientID %>').val('0');
                  }
                  _locationModel.maxqty = $('#<%=txtMaxBolxQty.ClientID %>').val();
                  _locationModel.removalstrategy = $('#<%=ddlRemovelStrategy.ClientID %>').val();
                  _locationModel.putawaystrategy = $('#<%=ddlPutAwayStrategy.ClientID %>').val();
                  _locationModel.barcode = $('#<%=barcode.ClientID %>').val();
                  _locationModel.qrcode = $('#<%=qrcode.ClientID %>').val();
                  _locationModel.pickseq = $('#<%=chkPickSequence.ClientID %>').is(":checked");
                  _locationModel.picklocation = $('#<%=chkPickableLocation.ClientID %>').is(":checked")
                  _locationModel.isliftassist = $('#<%=ChkIsLiftAssist.ClientID %>' ).is(":checked");
                  _locationModel.isrowrestricted = $('#<%=ChkIsRowRestricted.ClientID %>').is(":checked");
                  _locationModel.isscraploc = $('#<%=ChkIsScrapLocation.ClientID %>').is(":checked");
                  _locationModel.isreturnloc = $('#<%=ChkReturnLocation.ClientID %>').is(":checked");
                  _locationModel.isbinlocation = $('#<%=chkIsBinLocation.ClientID %>').is(":checked");
                  _locationModel.binrange = $('#calc-bin').val();
                  $.ajax({
                      type: "POST",
                      url: "WHLocation.aspx/SaveLocation",
                        data: JSON.stringify({ _locationModel: _locationModel }),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (data) {
                          if (data.d == "Duplicate Location.") {
                              swal("", data.d, "error");
                          }
                          else if (data.d == "This location already exits in bin.") {
                              swal("", data.d, "error");
                          }
                          else {
                              swal("", data.d, "success");
                              window.location = "LocationDashboard.aspx";
                          }
                      }
                  });                  
              }
          }), $(".validation-wizard").validate({
              ignore: "input[type=hidden]"
              , errorClass: "text-danger"
              , successClass: "text-success"
              , highlight: function (element, errorClass) {
                  $(element).removeClass(errorClass)
              }
              , unhighlight: function (element, errorClass) {
                  $(element).removeClass(errorClass)
              }
              , errorPlacement: function (error, element) {
                  error.insertAfter(element)
              }
              , rules: {
                  email: {
                      email: !0
                  }
              }
          });

          $("#binRangeid input").on("input change", function (event) {
              var parameterName = $(this).attr("id").split("calc-")[1];
              switch (parameterName) {
                  case "bin":
                      $("#calc-bin_value").html("Bin Range: " + $(this).val());
                      break;
              }
          });
           $('#<%=chkIsBinLocation.ClientID %>').click(function() {
               if ($(this).is(':checked')) {
                   $('#<%=binid.ClientID %>').val('');
                   $('#<%=binid.ClientID %>').attr('disabled', true);
                   $('#<%=barcode.ClientID %>').attr('disabled', true);
                   $('#<%=qrcode.ClientID %>').attr('disabled', true);
                   $('#binRangeid').show();
               }
               else {
                   $('#<%=binid.ClientID %>').attr('disabled', false);
                   $('#<%=barcode.ClientID %>').attr('disabled', false);
                   $('#<%=qrcode.ClientID %>').attr('disabled', false);
                   $('#binRangeid').hide();
               }
          });        
      });      
  </script>
</asp:Content>