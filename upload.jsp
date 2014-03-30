<% String pageName = "upload"; %>
<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	int personID = (Integer) session.getAttribute("id");

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	ArrayList patientIDs = new ArrayList();
	ArrayList patientNames = new ArrayList();
	String sql = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
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
	    patientIDs.add((rset.getInt(1)));
	    patientNames.add((rset.getString(2)).trim());
	}
	
	ArrayList doctorIDs = new ArrayList();
	ArrayList doctorNames = new ArrayList();
	sql = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
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
	
	try
	{
	    conn.close();
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
%>
<!-- allows the user to enter the radiology record-->
<div class="container">
	<form name="RecordForm" action="uploadRecord.jsp" method="post" role="form">
		<h1>Enter Radiology Record</h1>
		PATIENT:
		<br>
		<select name="PATIENTID" style="width:220px">
			<%
				for (int i = 0; i < patientIDs.size(); i++)
				{
				    out.println("<option value = " + patientIDs.get(i) + ">" + patientNames.get(i) + "</option>");
				}
			%>
		</select>
		<br>
		DOCTOR:
		<br>
		<select name="DOCTORID" style="width:220px">
			<%
				for (int i = 0; i < doctorIDs.size(); i++)
				{
				    out.println("<option value = " + doctorIDs.get(i) + ">" + doctorNames.get(i) + "</option>");
				}
			%>
		</select>
		<br>
		Test Type:
		<br>
		<input type="text" name="TESTTYPE" size="25" maxlength="24" required>
		<br>
		Prescribing Date:
		<br>
		<input type="text" name="PRESCRIBE" size="10" maxlength="11" placeholder="DD-MMM-YYYY" required>
		<br>
		Test Date:
		<br>
		<input type="text" name="TESTDATE" size="10" maxlength="11" placeholder="DD-MMM-YYYY" required>
		<br>
		Diagnosis:
		<br>
		<input type="text" name="DIAGNOSIS" size="100" maxlength="128" required>
		<br>
		Description:
		<br>
		<input type="text" name="DESCRIPTION" size="100" maxlength="1024" required>
		<br>
		<button type="submit" name="Submit">Upload</button>
	</form>
</div>
</body>
</html>