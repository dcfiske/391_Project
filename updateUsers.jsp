<%@ page import="java.sql.*" %>
<%
    if (request.getParameter("Submit") == null)
        response.sendRedirect("login.jsp");

	int personID = (Integer) session.getAttribute("id");
	
	//get the user input from the info page
	String newPwd1 = (request.getParameter("NEWPWD1")).trim();
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "UPDATE users SET password = '" + newPwd1 + "' " +
	        	 "WHERE person_id = '" + personID + "'";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	try
	{
	    conn.close();
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	response.sendRedirect("myinfo.jsp");
%>