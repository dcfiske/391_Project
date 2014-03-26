<%@ page import="java.sql.*" %>
<%
	String IDforURL = request.getParameter("personId").trim();
	int personID = Integer.parseInt(IDforURL);
	
	//get the user input from the info page
	String firstName = (request.getParameter("FIRSTNAME")).trim();
	String lastName = (request.getParameter("LASTNAME")).trim();
	String address = (request.getParameter("ADDRESS")).trim();
	String email = (request.getParameter("EMAIL")).trim();
	String phone = (request.getParameter("PHONE")).trim();
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "UPDATE persons SET first_name = '" + firstName + "', " +
	        						 "last_name = '" + lastName + "', " +
	        						 "address = '" + address + "', " +
	        						 "email = '" + email + "', " +
	        						 "phone = '" + phone + "' " +
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
	
	response.sendRedirect("Adminupdate.jsp?personId="+IDforURL);
%>
