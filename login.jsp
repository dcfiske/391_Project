<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Radiology Information System - Login</title>

<!-- Bootstrap CSS -->
<link href="./js/bootstrap-3.1.1-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Signin CSS -->
<link href="./js/bootstrap-3.1.1-dist/css/signin.css" rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="./js/jquery-2.1.0.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="./js/bootstrap-3.1.1-dist/js/bootstrap.min.js"></script>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<%
		if (session.getAttribute("id") != null)
		    response.sendRedirect("home.jsp");
	%>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="login.jsp">Radiology Information System</a>
			</div>
		</div>
	</div>
	<div class="container">
		<form name="LoginForm" action="checkLogin.jsp" method="post"
			class="form-signin" role="form">
			<h1 class=\"form-signin-heading\">
			<%
				if (request.getParameter("error") != null)
				{
				    out.println("Oops! Try again:");
				}
				else
				{
				    out.println("Sign In:");
				}
			%>
			</h1>
			<input type="text" name="USERID" class="form-control"
				placeholder="Username" required autofocus> <input
				type="password" name="PASSWD" class="form-control"
				placeholder="Password" required>
			<button type="submit" name="Submit"
				class="btn btn-lg btn-primary btn-block">Sign in</button>
		</form>
	</div>
	<!-- /container -->
</body>
</html>