<%@ page import="java.sql.*" %>
<%
	int patientID = Integer.parseInt(request.getParameter("PID").trim());
	int doctorID = Integer.parseInt(request.getParameter("DID").trim());
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//Update the new family doctor info by deleting the previous one and inserting the new info.
	Statement stmt = null;
	ResultSet rset = null;
	stmt = conn.createStatement();
	String sql = "";
	
	if (request.getParameter("Remove") != null)
	{
		sql = "DELETE FROM family_doctor WHERE doctor_id = '" + doctorID + "' AND patient_id = '" + patientID + "'";
	}
	else
	{	    
		sql = "INSERT INTO family_doctor VALUES ('" + doctorID + "', '" + 
		          									  patientID + "')";
	}
	
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
	
	response.sendRedirect("managePatients.jsp");
%>
