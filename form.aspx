<%@ Page Title="" Language="C#" MasterPageFile="~/BOLXMasterPage.master" AutoEventWireup="true" CodeFile="form.aspx.cs" Inherits="form" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container-full">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="d-flex align-items-center">
				<div class="me-auto">
					<h4 class="page-title">General Form Elements</h4>
					<div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
								<li class="breadcrumb-item" aria-current="page">Forms</li>
								<li class="breadcrumb-item active" aria-current="page">General Form Elements</li>
							</ol>
						</nav>
					</div>
				</div>
				
			</div>
		</div>	  

		<!-- Main content -->
		<section class="content">
			<div class="row">			  
				<div class="col-lg-6 col-12">
					  <div class="box">
						<div class="box-header with-border">
						  <h4 class="box-title">Sample form 1</h4>
						</div>
						<!-- /.box-header -->
						<form class="form">
							<div class="box-body">
								<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i> Personal Info</h4>
								<hr class="my-15">
								<div class="row">
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">First Name</label>
									  <input type="text" class="form-control" placeholder="First Name">
									</div>
								  </div>
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">Last Name</label>
									  <input type="text" class="form-control" placeholder="Last Name">
									</div>
								  </div>
								</div>
								<div class="row">
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">E-mail</label>
									  <input type="text" class="form-control" placeholder="E-mail">
									</div>
								  </div>
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">Contact Number</label>
									  <input type="text" class="form-control" placeholder="Phone">
									</div>
								  </div>
								</div>
								<h4 class="box-title text-info mb-0 mt-20"><i class="ti-save me-15"></i> Requirements</h4>
								<hr class="my-15">
								<div class="form-group">
								  <label class="form-label">Company</label>
								  <input type="text" class="form-control" placeholder="Company Name">
								</div>
								<div class="row">
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">Interested in</label>
									  <select class="form-select">
										<option>Interested in</option>
										<option>design</option>
										<option>development</option>
										<option>illustration</option>
										<option>branding</option>
										<option>video</option>
									  </select>
									</div>
								  </div>
								  <div class="col-md-6">
									<div class="form-group">
									  <label class="form-label">Budget</label>
									  <select class="form-select">
										<option>Budget</option>
										<option>less than 5000$</option>
										<option>5000$ - 10000$</option>
										<option>10000$ - 20000$</option>
										<option>more than 20000$</option>
									  </select>
									</div>
								  </div>
								</div>
								<div class="form-group">
								  <label class="form-label">Select File</label>
								  <label class="file">
									<input type="file" id="file">
								  </label>
								</div>
								<div class="form-group">
								  <label class="form-label">About Project</label>
								  <textarea rows="5" class="form-control" placeholder="About Project"></textarea>
								</div>
							</div>
							<!-- /.box-body -->
							<div class="box-footer">
								<button type="button" class="btn btn-warning me-1">
								  <i class="ti-trash"></i> Cancel
								</button>
								<button type="submit" class="btn btn-primary">
								  <i class="ti-save-alt"></i> Save
								</button>
							</div>  
						</form>
					  </div>
					  <!-- /.box -->			
				</div>  
                
		    </div>
		  <!-- /.row -->

		</section>
		<!-- /.content -->
	  </div>
</asp:Content>

