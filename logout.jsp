<%
	//log out the current user
	session.invalidate();
	response.sendRedirect("login.jsp");
%>
