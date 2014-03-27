<%@ page import="java.sql.*" %>
<%
	String IDforURL = request.getParameter("personId").trim();
	int personID = Integer.parseInt(IDforURL);
	
	//get the user input from the info page
	String doctorId = (request.getParameter("olddocId")).trim();
	String oldpatId = (request.getParameter("oldpatId")).trim();
	String patientId = (request.getParameter("patId")).trim();
	String doctorId = (request.getParameter("docId")).trim();

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "UPDATE FAMILY_DOCTOR SET PATIENT_ID = '" + patientId + "', " +
	        						 "DOCTOR_ID = '" + doctorId + "', " +
	        	 "WHERE PATIENT_ID = '" + oldpatId + "', " + "DOCTOR_ID = '" + olddocId + "'" ";
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
