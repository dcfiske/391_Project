<!DOCTYPE html>
<html lang="en">
<head>
<title>Logout Module</title>
</head>
<body>
	<%
		session.invalidate();
		response.sendRedirect("login.jsp");
	%>
</body>
</html>