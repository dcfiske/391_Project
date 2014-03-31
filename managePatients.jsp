<% String pageName = "manager"; %>
<%@ include file="menu.jsp" %>
<div class="container">
	<form name="doctorForm" method="get" role="form">
		<h1>Manage Patients</h1>
		Select Doctor:
		<br>
		<select name="DOCTORID" style="width:220px">
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%	
	//collect and print the list of the doctors names
	Statement stmt = null;
	ResultSet rset = null;
	String doctorID = "";
	ArrayList doctorIDs = new ArrayList();
	ArrayList doctorNames = new ArrayList();
	String sql = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
				 " FROM persons p, users u" +
				 " WHERE p.person_id = u.person_id AND u.class = 'd'";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	while (rset != null && rset.next())
	{
	    doctorIDs.add((rset.getInt(1)));
	    doctorNames.add((rset.getString(2)).trim());
	}

	if (request.getParameter("DOCTORID") != null)
	    doctorID = request.getParameter("DOCTORID");
	
	for(int i = 0; i < doctorIDs.size(); i++)
	{
	    if (doctorID.equals(doctorIDs.get(i)))
			out.println("<option selected=\"selected\" value=" + doctorIDs.get(i) + ">" + doctorNames.get(i) + "</option>");
	    else
	        out.println("<option value=" + doctorIDs.get(i) + ">" + doctorNames.get(i) + "</option>");
	}
%>
		</select>
		<button type="submit" name="Submit" value="true">Select Doctor</button>
	</form>
<%
	if (request.getParameter("Submit") != null)
	{   
		ArrayList docPatientIDs = new ArrayList();
		ArrayList docPatientNames = new ArrayList();
		//collect and pritn the list of doctor names for the family_doctor table
		sql = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
			 " FROM persons p, family_doctor fd" +
			 " WHERE fd.patient_id = p.person_id AND fd.doctor_id = '" + doctorID + "'";
		
		try
		{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sql);
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		while (rset != null && rset.next())
		{
		    docPatientIDs.add((rset.getInt(1)));
		    docPatientNames.add((rset.getString(2)).trim());
		}
		
		ArrayList patientIDs = new ArrayList();
		ArrayList patientNames = new ArrayList();
		//collect and print the list of patient names
		sql = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
			  " FROM persons p, users u" +
			  " WHERE p.person_id = u.person_id AND u.class = 'p'";
		
		try
		{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sql);
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		while (rset != null && rset.next())
		{
		    if (!docPatientIDs.contains(rset.getInt(1)))
		    {
		        patientIDs.add(rset.getInt(1));
		    	patientNames.add((rset.getString(2)).trim());
		    }
		}
		
		out.println("<form name=\"patientForm1\" action=\"updateFamilyDoctor.jsp\" method=\"post\" role=\"form\">");
		out.println("<br>Remove Patient:<br>");
		out.println("<select name=\"PID\" style=\"width:220px\">");
		for(int i = 0; i < docPatientIDs.size(); i++)
		{
			out.println("<option value=" + docPatientIDs.get(i) + ">" + docPatientNames.get(i) + "</option>");
		}
		out.println("</select> <input type=\"hidden\" name=\"DID\" value=" + doctorID + " required>");
		out.println("<button type=\"submit\" name=\"Remove\">Remove</button></form>");
		
		out.println("<form name=\"patientForm2\" action=\"updateFamilyDoctor.jsp\" method=\"post\" role=\"form\">");
		out.println("<br>Add Patient<br>");
		out.println("<select name=\"PID\" style=\"width:220px\">");
		for(int i = 0; i < patientIDs.size(); i++)
		{
			out.println("<option value=" + patientIDs.get(i) + ">" + patientNames.get(i) + "</option>");
		}
		out.println("</select> <input type=\"hidden\" name=\"DID\" value=" + doctorID + " required>");
		out.println("<button type=\"submit\" name=\"Add\">Add</button></form>");
	}

	try
	{
	    conn.close();
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
%>
</div>
</body>
</html>
	
