<% String pageName = "search"; %>
<%@ include file="menu.jsp" %>
<div class="container">
	<form name="searchForm" method="post" role="form">
		<h1>Search</h1>
		<input type="text" name="KEYWORDS" size="100" placeholder="Keywords...">
		<BR>
		FROM: <input type="text" name="FROM" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
		TO: <input type="text" name="TO" size="12" maxlength="11" placeholder="DD-MMM-YYYY">
		<BR>
		ORDER BY: <select name="ORDER">
					<option value="newest">Newest First</option>
					<option value="oldest">Oldest First</option>
					<option value="rank">Rank</option>
				 </select>
		<BR>
		<button type="submit" name="Submit">Fetch</button>
	</form>
</div>
<%@ page import="java.sql.*"%>
<%
	int personID = (Integer) session.getAttribute("id");

	if (request.getParameter("Submit") != null)
	{
		String keywords[] = (request.getParameter("KEYWORDS")).trim().split("\\s+");
		String dateFrom = (request.getParameter("FROM")).trim();
		String dateTo = (request.getParameter("TO")).trim();
		String orderBy = (request.getParameter("ORDER")).trim();
		
		//establish the connection to the underlying database
		Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
		//select the user table from the underlying db and validate the user name and password
		Statement stmt = null;
		ResultSet rset = null;

		String sql = "SELECT r.record_id, image_id, CONCAT(p1.first_name, CONCAT(' ', p1.last_name))," +
				  	 " CONCAT(p2.first_name, CONCAT(' ', p2.last_name))," +
		    	  	 " CONCAT(p3.first_name, CONCAT(' ', p3.last_name))," +
				 	 " test_type, TO_CHAR(prescribing_date, 'DD-MON-YYYY'), TO_CHAR(test_date, 'DD-MON-YYYY'), diagnosis, description" +
				 	 " FROM radiology_record r LEFT OUTER JOIN pacs_images i ON r.record_id = i.record_id, persons p1, persons p2, persons p3" +
				 	 " WHERE p1.person_id = r.patient_id AND p2.person_id = r.doctor_id AND p3.person_id = r.radiologist_id";
		if (userClass.equals("r"))
		{
		    sql += " AND r.radiologist_id = '" + personID + "'";
		}
		else if (userClass.equals("d"))
		{
		    sql += " AND r.doctor_id = '" + personID + "'";
		}
		else if (userClass.equals("p"))
		{
		    sql += " AND r.patient_id = '" + personID + "'";
		}
		if (!keywords[0].isEmpty())
		{
			sql += " AND (CONTAINS(p1.first_name, '" + keywords[0];
			for (int i = 1; i < keywords.length; i++)
			{
			    sql += " AND " + keywords[i];
			}
			sql += "', 1) > 0 OR CONTAINS(p1.last_name, '" + keywords[0];
			for (int i = 1; i < keywords.length; i++)
			{
			    sql += " AND " + keywords[i];
			}
			sql += "', 2) > 0 OR CONTAINS(r.diagnosis, '" + keywords[0];
			for (int i = 1; i < keywords.length; i++)
			{
			    sql += " AND " + keywords[i];
			}
			sql += "', 3) > 0 OR CONTAINS(r.description, '" + keywords[0];
			for (int i = 1; i < keywords.length; i++)
			{
			    sql += " AND " + keywords[i];
			}
			sql += "', 4) > 0)";
		}
		if (!dateFrom.isEmpty())
		{
		    sql += " AND test_date >= '" + dateFrom + "'";
		}
		if (!dateTo.isEmpty())
		{
		    sql += " AND test_date <= '" + dateTo + "'";
		}
		sql += " ORDER BY";
		if (orderBy.equals("newest"))
		    sql += " test_date, record_id DESC";
		else if (orderBy.equals("oldest"))
		    sql += " test_date, record_id ASC";
		else if (keywords.length > 0)
		    sql += " (6*(SCORE(1)+SCORE(2)) + 3*SCORE(3) + SCORE(4)), record_id DESC";
		else
		    sql += " record_id DESC";
		
		try
		{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sql);
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		int recordID = 0;
		int imageID = 0;
		String patientName = "";
		String doctorName = "";
		String radiologistName = "";
		String testType = "";
		String pDate = "";
		String tDate = "";
		String diagnosis = "";
		String desc = "";
		
		out.println("<div class=\"container\">");
		//out.println(sql);
		out.println("<h1>Results</h1>");
		out.println("<table class=\"table table-bordered\">");
		out.println("<tr class=\"active\">");
		out.println("<th>Patient</th>");
		out.println("<th>Doctor</th>");
		out.println("<th>Radiologist</th>");
		out.println("<th>Test Type</th>");
		out.println("<th>Prescription Date</th>");
		out.println("<th>Test Date</th>");
		out.println("<th>Diagnosis</th>");
		out.println("<th>Description</th>");
		out.println("<th>Images</th>");
		out.println("</tr>");
		
		boolean hasNext = false;
		if (rset != null && rset.next())
		    hasNext = true;
		
		while (hasNext)
		{
		    recordID = rset.getInt(1);
		    imageID = rset.getInt(2);
		    out.println("<tr>");
		    out.println("<td>");
		    patientName = rset.getString(3).trim();
		    out.println(patientName);
		    out.println("</td>");
		    out.println("<td>");
		    doctorName = rset.getString(4).trim();
		    out.println(doctorName);
		    out.println("</td>");
		    out.println("<td>");
		    radiologistName = rset.getString(5).trim();
		    out.println(radiologistName);
		    out.println("</td>");
		    out.println("<td>");
		    testType = (rset.getString(6)).trim();
		    out.println(testType);
		    out.println("</td>");
		    out.println("<td>");
		    pDate = (rset.getString(7)).trim();
		    out.println(pDate);
		    out.println("</td>");
		    out.println("<td>");
		    tDate = (rset.getString(8)).trim();
		    out.println(tDate);
		    out.println("</td>");
		    out.println("<td>");
		    diagnosis = (rset.getString(9)).trim();
		    out.println(diagnosis);
		    out.println("</td>");
		    out.println("<td>");
		    desc = (rset.getString(10)).trim();
		    out.println(desc);
		    out.println("</td>");
		    out.println("<td>");
		    if (imageID != 0)
		    	out.println("<a href=\"GetOnePic?" + imageID + "\"><img src=\"GetOnePic?" + imageID +"\" style=\"display:block; width:100px; height:auto;\"></a>");
		    hasNext = rset.next();
		    while (hasNext && (rset.getInt(1) == recordID))
		    {
			    imageID = rset.getInt(2);
			    out.println("<a href=\"GetOnePic?" + imageID + "\"><img src=\"GetOnePic?" + imageID +"\" style=\"display:block; width:100px; height:auto;\"></a>");
			    hasNext = rset.next();
		    }
		    out.println("</td>");
		    out.println("</tr>");
		}
		out.println("</table>");
		out.println("</div>");
		
		try
		{
		    conn.close();
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
	}
%>
</body>
</html>
