<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Radiology Information System</title>

<!-- Bootstrap CSS -->
<link href="./js/bootstrap-3.1.1-dist/css/bootstrap.min.css" rel="stylesheet">
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
		String userClass = "";
		if (session.getAttribute("id") == null)
		    response.sendRedirect("login.jsp");
		else
		    userClass = (String) session.getAttribute("class");
	%>
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="home.jsp">Radiology Information System</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="home.jsp">Home</a></li>
            <%
				if (userClass.equals("a"))
				{
				    out.println("<li><a href=\"userManager.jsp\">User Management</a></li>");
				    out.println("<li><a href=\"reports.jsp\">Reports</a></li>");
				    out.println("<li><a href=\"analysis.jsp\">Data Analysis</a></li>");
				}
				else if (userClass.equals("r"))
				{
				    out.println("<li><a href=\"upload.jsp\">Upload</a></li>");
				}
	    %>
            <li><a href="search.jsp">Search</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="myinfo.jsp">My Info</a></li>
            <li><a href="logout.jsp">Logout</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
