<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="icon" href="images/favicon/favicon.ico">

	<title>BOLX - Log in </title>

	<!-- Vendors Style-->
	<link rel="stylesheet" href="css/vendors_css.css">

	<!-- Style-->
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/skin_color.css">
	<style>
        .colorChange, .colorChange:hover {
            background-color: #242058 !important;
            border-color: #242058 !important;
        }
	</style>
</head>
<body class="hold-transition theme-primary bg-img" style="background-image: url(images/auth-bg/bg-1.jpg)">
    
    <div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">

			<div class="col-12">
				<div class="row justify-content-center g-0">
					<div class="col-lg-5 col-md-5 col-12">
						<div class="bg-white rounded10 shadow-lg">
							<div class="content-top-agile p-20 pb-0">
								<img src="images/Bolx_Logo_sm.png" class="logo mt-10"/>
								<!--<p class="mb-0">Sign in to continue to Deposito.</p>-->
							</div>
							<div class="p-40">
                                <form id="form1" runat="server">
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-user"></i></span>
                                            <asp:TextBox ID="txtLogin" class="form-control ps-15 bg-transparent" runat="server" placeholder="Username"></asp:TextBox>
										</div>
									</div>
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text  bg-transparent"><i class="ti-lock"></i></span>
											<asp:TextBox ID="txtPassword" TextMode="Password" class="form-control ps-15 bg-transparent" runat="server" placeholder="Password"></asp:TextBox>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<div class="checkbox">
												<input type="checkbox" id="basic_checkbox_1">
												<label for="basic_checkbox_1">Remember Me</label>
											</div>
										</div>
										<!-- /.col -->
										<div class="col-12 text-center">
                                            <asp:Button ID="btnLogin" runat="server" Text="SIGN IN" style="width:100%;" class="btn btn-primary mt-10 colorChange" onclick="LoginBtn_Click" />
										</div>
										<!-- /.col -->
									</div>
                                    </form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Vendor JS -->
	<script src="js/vendors.min.js"></script>
	<script src="js/pages/chat-popup.js"></script>
	<script src="assets/icons/feather-icons/feather.min.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script>

      // When the browser is ready...
      $(function () {

          // Setup form validation on the #register-form element
          $("#form1").validate({
              rules: {
                  txtLogin: "required",
                  txtPassword: "required"
              },
          submitHandler: function (form) {
              form.submit();
          }
      });

  });
  
  </script>
</body>
</html>
