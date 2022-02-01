<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BOLXMasterPage.master" CodeFile="LocationCapacityDashboard.aspx.cs" Inherits="LocationCapacityDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <script src="js/jquery.min.js"></script>
      <style>
          .table > tbody > tr > td {
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
                    <h4 class="page-title">Location Capacity Dashboard</h4>
                    <div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-calendar"></i></a></li>
								<li class="breadcrumb-item active bold" aria-current="page"><a href="WHLocation.aspx"><strong>Create Location</strong></a></li>
								<li class="breadcrumb-item active" aria-current="page"> Capacity Dashboard</li>                  
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
					 <h4 class="box-title text-info mb-0"><i class="ti-dashboard me-15"></i>Location Capacity Dashboard</h4>        
                        	 <h4 class="box-title text-info mb-0" style="width:65%">&nbsp;</h4>      
                         <%-- <a href="Location.aspx" class="btn btn-primary">
                            <i class="fa fa-map-marker"></i> Create Location
                        </a>--%>
					</div>
					<div class="box-body">		
                           <div class="no-padding table-responsive">
				<table id="locationtableCapacity" class="table table-bordered table-striped table-responsive">
								<thead>
									<tr>
                                     <%--   <th style="display:none">Id</th>--%>
                                        <th style="display:none">Warehouse</th>
										<th>Location</th>
										<th>SKU's</th>
										<th>Stock Capacity</th>
                                        <th>Balance Quanty</th>
										<th>% Occupied</th>
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
        </div>
    <script type="text/javascript">
        $(document).ready(function () {
          
        });
    </script>
</asp:Content>