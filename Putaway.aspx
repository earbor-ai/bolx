<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master" CodeFile="Putaway.aspx.cs" Inherits="Putaway" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <a href="barcodefonts/3of9Barcode.woff">barcodefonts/3of9Barcode.woff</a>
  <script src="js/jquery.min.js"></script>
     <link href="  https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css" rel="stylesheet" /> 
    <style>

        @font-face {
            font-family: 3of9Barcode;
            src: url(../barcodefonts/3of9Barcode.woff);
        }

        .hidden {
            display: none;
        }
        legend {
            background-color: gray;
            color: white;
            padding: 5px 10px;
            font-size: 14px;
        }
         td.dt-control {
            background: url(https://www.datatables.net/examples/resources/details_open.png) no-repeat center center;
            cursor: pointer;
            width: 30px;
            transition: .5s;
        }

        tr.shown td.dt-control {
            background: url(https://www.datatables.net/examples/resources/details_close.png) no-repeat center center;
            width: 30px;
            transition: .5s;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-full">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="d-flex align-items-center">
                <div class="me-auto">
                    <h4 class="page-title">Put Away</h4>
                    <div class="d-inline-block align-items-center">
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>
                                <%--	<li class="breadcrumb-item active bold" aria-current="page"><a href="WHLocation.aspx"><strong>Create Location</strong></a></li>
								<li class="breadcrumb-item active" aria-current="page"> Capacity Dashboard</li>  --%>
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
                            <h4 class="box-title text-info mb-0"><i class="ti-layers-alt me-15"></i>Put Away</h4>
                            <h4 class="box-title text-info mb-0" style="width: 65%">&nbsp;</h4>                           
                            <asp:Label ID="lblErrMsg" runat="server" class="badge badge-lg badge-danger-red text-wrap text-start float-right" Style="width: 40%;"></asp:Label>
                            <asp:Label ID="lblSuccMsg" runat="server" class="badge badge-lg bg-success text-wrap text-start float-right" Style="width: 40%;"></asp:Label>
                        </div>
                        <div class="box-body">

                            <img id="coupon" style="display:none" />

                            <div class="col-lg-8 m-auto">
                                <div class="row" id="form-1">
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label class="form-label">PO Number</label>
                                            <asp:TextBox ID="txtPONumber" class="form-control" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label class="form-label">SKU</label>
                                            <asp:TextBox ID="txtSKU" class="form-control" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label class="form-label">Client</label>
                                            <asp:DropDownList ID="ddlSearchClient" class="form-select" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                        <br />
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" class="btn btn-primary" OnClick="BtnSubmit_Click" Style="float: right;" />
                                    </div>
                                </div>
                            </div>
                            <hr />

                            <div id="locationdiv" runat="server" visible="false">
                                <fieldset>
                                    <legend style="color: white; font-weight: bold;">PO & Assign Location</legend>
                                    <button id="btn-show-all-children" type="button" class="btn btn-facebook btn-sm"> Expand All</button> <button id="btn-hide-all-children" class="btn btn-facebook btn-sm" type="button" disabled="disabled"> Collapse All</button>
                                       <div class="no-padding table-responsive">
                                    <table id="putwaytable" class="table table-bordered table-striped  table-responsive display">
                                        <thead>
                                            <tr>  
                                                <th></th>
                                                <th style="display: none">skuid</th>                                        
                                                <th>PO Number</th>
                                                <th>SKU's</th>
                                                <th>Description</th>
                                                <th>PO Received Quanty</th>
                                                <th style="width:75px">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="locationbody" runat="server">
                                        </tbody>
                                    </table>
                                        </div>
                                </fieldset>
                            </div>

                            <div id="locDetailsdiv" runat="server" style="display: block; padding-top:7px; padding-left:10%;padding-right:10%;">
                                    <table id="locDetails" class="table table-bordered table-hover display nowrap margin-top-10 w-p100" style="width: 100%;">
                                        <thead style="height:25px;">
                                            <tr >
                                                <th style="display: none">locationid</th>
                                                <th>Location</th>
                                                <th>Putaway Qty</th>
                                                <th>Label Print</th>
                                            </tr>
                                        </thead>
                                        <tbody id="detbody"></tbody>
                                    </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <div class="modal fade none-border" id="assignLocation">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 350px;">
            <div class="modal-header">
                <h4 class="modal-title">Assign Location</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-md-12">
                              <label for="example-text-input" class="form-label">PO Quantity : </label><span id="poqty" runat="server"></span>                   
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                              <label for="example-text-input" class="form-label">PO Available Quantity : </label><span id="poavailqty" runat="server"></span>   
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                              <div class="form-group">
                                        <label for="example-text-input" class="form-label">Put Away Quantity</label><span style="color: red;">*</span>                   
                                          <asp:TextBox CssClass="form-control" type="number" ID="txtoutway" runat="server" onchange="ValidateBal();" TextMode="Number"   />                                  
                                   </div> 
                            </div>
                        </div>
                          <div class="row">
                            <div class="col-md-12">
                               <div class="form-group">
                                        <label for="example-text-input" class="form-label">Location</label><span style="color: red;">*</span>                   
                                          <asp:DropDownList ID="ddlLocation" class="form-select" runat="server"></asp:DropDownList>                                  
                                    </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success save-category" Text="Save" />
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
         
            </div>
        </div>
    </div>
</div>
  <script type="text/javascript">
      var puttable;
      var blanceqty = 0, skuid = 0, SKU = '', LocationId = 0, reqty = 0;
      var ponumber;
          $('#<%=locDetailsdiv.ClientID %>').hide();
            $(document).ready(function () {
                puttable = $("#putwaytable").DataTable({
                    'paging': false,
                    'lengthChange': false,
                    'searching': false,
                    'ordering': true,
                    'info': false,
                    'autoWidth': false
                });
            });
       
       /* Show or hide child table po/sku assign  location details*/
      $('#putwaytable tbody').on('click', 'td.dt-control', function () {
          var tr = $(this).closest('tr');
          var row = puttable.row(tr);
          if (row.child.isShown()) {
              destroyChild(row);
              tr.removeClass('shown');
          } else {
              // Open this row
              createChild(row);
              tr.addClass('shown');
          }
      });
        // Handle click on "Expand All" button
      $('#btn-show-all-children').on('click', function () {
          $("#btn-hide-all-children").prop("disabled", false);
          $("#btn-show-all-children").prop("disabled", true);
          //if ($('#btn-show-all-children').html() == "Collapse All") {
          //    $('#btn-show-all-children').html("Expand All");
          //} else {
          //    $('#btn-show-all-children').html("Collapse All");
          //}

          puttable.rows(':not(.parent)').nodes().to$().find('td:first-child').trigger('click');
      });

    
      $("#btn-hide-all-children").click(function () {
              $("#btn-hide-all-children").prop("disabled", true);
              $("#btn-show-all-children").prop("disabled", false);
          puttable.rows(':not(.parent)').nodes().to$().find('td:first-child').trigger('click');
      });

      function destroyChild(row) {
          var table = $("table", row.child());
          table.detach();
          table.DataTable().destroy();
          // And then hide the row
          row.child.hide();
      }

      var datalength;
      var total; 
      function createChild(row) {
          // This is the table we'll convert into a DataTable
          var table = $('<table class="display" width="50%"> <thead style="height:25px;"><tr > <th style="display: none">locationid</th> <th>Location</th><th>Putaway Qty</th><th>Label Print</th> </tr> </thead></table>');
          // Display it the child row
          row.child(table).show();
          var d = row.data();
          var obj = {}; obj.skuid = d[1];
          $.ajax({
              type: "POST",
              url: "Putaway.aspx/GetPOlocations",
              data: JSON.stringify(obj),
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  $("#detbody tr").remove();
                  $("#detbody").html('');
                  total = 0;
                  datalength = data.d.length;
                  for (var i = 0; i < data.d.length; i++) {
                      $("#detbody").append("<tr><td style='display:none'>" + data.d[i].locationid + "</td><td>" + data.d[i].location + "</td><td>" + data.d[i].recqty + "</td><td>     <img src='images/barcode.png' data-bs-toggle='tooltip' data-bs-original-title='Print Location label' alt='Location label print' height='32' width='50' onclick='PrintLabel(" + data.d[i].locationid + ")'/></td> </tr >");
                      total += data.d[i].recqty;
                  }
                  $("#detbody").append("<tr><td><b>Total Quantity</b></td><td><b>" + total + "</b></td><td>&nbsp;</td></tr>");
                   if (datalength > 0) {
                      table.append($("#detbody").html());
                  } else {
                        row.child("No records found").show();
                  }              
              }
          });
      }


       /* Open location assign popup */
      $('#putwaytable tbody').on('click', '#btnAloc', function () {
          var data = puttable.row($(this).parents('tr')).data();
          skuid = data[1];ponumber = data[2];
          var Receivedqty = data[5];
          var obj = {}; obj.skuid = skuid;
          $.ajax({
              type: "POST",
              url: "Putaway.aspx/GetOnHandQuatityBySkuId",
              data: JSON.stringify(obj),
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  blanceqty = Receivedqty - data.d;
                  $('#<%=poqty.ClientID %>').text(Receivedqty);
                      $('#<%=poavailqty.ClientID %>').text(blanceqty);
                      if (blanceqty == 0) {
                          $('#<%=txtoutway.ClientID %>').attr("disabled", true);
                          $('#<%=ddlLocation.ClientID %>').attr("disabled", true);
                          $('#<%=btnSave.ClientID %>').attr("disabled", true);
                          $('#<%=poavailqty.ClientID %>').css('color', 'black');
                      } else {
                          $('#<%=txtoutway.ClientID %>').val('');
                          $('#<%=ddlLocation.ClientID %>').val('');
                          $('#<%=btnSave.ClientID %>').attr("disabled", false);
                          $('#<%=txtoutway.ClientID %>').attr("disabled", false);
                          $('#<%=ddlLocation.ClientID %>').attr("disabled", false);
                          $('#<%=poavailqty.ClientID %>').css('color', 'black');
                  }
              }
          });
          $("#assignLocation").modal('show');
      });

       /* Validation for available received quantity*/
      function ValidateBal() {
          var bal = blanceqty - $('#<%=txtoutway.ClientID %>').val();
          $('#<%=poavailqty.ClientID %>').text(bal);
          if (($('#<%=txtoutway.ClientID %>').val() <= blanceqty)) {
              $('#<%=btnSave.ClientID %>').attr("disabled", false);
                    $('#<%=poavailqty.ClientID %>').css('color', 'black');
                }
                else {
                    $('#<%=btnSave.ClientID %>').attr("disabled", true);
                    $('#<%=poavailqty.ClientID %>').css('color', 'red');
          }
      }       

       /* Save the location assign for po and sku*/
      $('#<%=btnSave.ClientID %>').click(function () {
          var obj = {}; obj.locationid = $('#<%=ddlLocation.ClientID %>').val();
          obj.skuid = skuid; obj.putwayqty = $('#<%=txtoutway.ClientID %>').val();
          obj.ponumber = ponumber;
          $.ajax({
              type: "POST",
              url: "Putaway.aspx/SavePutaway",
              data: JSON.stringify(obj),
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (r) {
              }
          });
      });



       /* Generate and print barcode */
      function PrintLabel(id) {
          var obj = {}; obj.locationId = id;
          $.ajax({
              type: "POST",
              url: "Putaway.aspx/GererateBarcode",
              data: JSON.stringify(obj),
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  var myWindow = window.open("", "Image", 'width=450,height=350,toolbar=0,menubar=0,location=0');
                  myWindow.document.write('<img src="' + data.d + '"/>');
                  myWindow.document.close();
                  myWindow.print();
              }
          });
      }




      ///
      $('#putwaytable tbody').on('click', '#btngetloc', function () {
          var rowdata = puttable.row($(this).parents('tr')).data();
          var obj = {}; obj.skuid = rowdata[1];
          $.ajax({
              type: "POST",
              url: "Putaway.aspx/GetPOlocations",
              data: JSON.stringify(obj),
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  $("#detbody tr").remove();
                  for (var i = 0; i < data.d.length; i++) {
                      $("#detbody").append("<tr><td style='display:none'>" + data.d[i].locationid + "</td><td>" + data.d[i].location + "</td><td>" + data.d[i].recqty + "</td><td>     <img src='images/printer.png' data-bs-toggle='tooltip' data-bs-original-title='Print Location label' alt='Location label print' height='32' width='32' onclick='PrintLabel(" + data.d[i].locationid + ")'/></td> </tr >");
                  }
                  $('#<%=locDetailsdiv.ClientID %>').show();
                 $("#legendDetails").text(rowdata[5] + ' , ' + rowdata[7] + ' : Location Details & Print Label');
             }
         });
     });
  </script>
</asp:Content>

