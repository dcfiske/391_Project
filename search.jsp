<%@ include file="menu.jsp" %>
<div class="container">
	<form name="searchForm" method="post" role="form">
		<h1 class=\"form-signin-heading\">Search</h1>
		<input type="text" name="KEYWORDS" size="100" placeholder="Keywords..." required>
		<BR>
		FROM: <input type="text" name="FROM" size="10" maxlength="10" placeholder="MM/DD/YYYY">
		TO: <input type="text" name="TO" size="10" maxlength="10" placeholder="MM/DD/YYYY">
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
		String sql = "SELECT * FROM radiology_record WHERE CONTAINS(description, '" + keywords[0];
		for (int i = 1; i < keywords.length; i++)
		{
		    sql += " AND " + keywords[i];
		}
		sql += "', 1) > 0";
		if (!dateFrom.isEmpty())
		{
		    sql += " AND test_date >= dateFrom";
		}
		if (!dateTo.isEmpty())
		{
		    sql += " AND test_date <= dateTo";
		}
		sql += " ORDER BY SCORE(1)";
		
// 		try
// 		{
// 		    stmt = conn.createStatement();
// 		    rset = stmt.executeQuery(sql);
// 		} catch (Exception ex)
// 		{
// 		    out.println("<hr>" + ex.getMessage() + "<hr>");
// 		}
		
		int recordID = 0;
		int patientID = 0;
		int doctorID = 0;
		int radioID = 0;
		String testType = "";
		String pDate = "";
		String tDate = "";
		String diagnosis = "";
		String desc = "";
		
		out.println("<div class=\"container\">");
		out.println(sql);
		out.println("<h1>Results</h1>");
		out.println("<table class=\"table table-bordered\">");
		out.println("<tr class=\"active\">");
		out.println("<th>Record</th>");
		out.println("<th>Patient</th>");
		out.println("<th>Doctor</th>");
		out.println("<th>Radiologist</th>");
		out.println("<th>Test Type</th>");
		out.println("<th>Prescription Date</th>");
		out.println("<th>Test Date</th>");
		out.println("<th>Diagnosis</th>");
		out.println("<th>Description</th>");
		out.println("</tr>");
		while (rset != null && rset.next())
		{
		    out.println("<tr>");
		    out.println("<td>");
		    recordID = rset.getInt(1);
		    out.println(recordID);
		    out.println("</td>");
		    out.println("<td>");
		    patientID = rset.getInt(2);
		    out.println(patientID);
		    out.println("</td>");
		    out.println("<td>");
		    doctorID = rset.getInt(3);
		    out.println(doctorID);
		    out.println("</td>");
		    out.println("<td>");
		    radioID = rset.getInt(4);
		    out.println(radioID);
		    out.println("</td>");
		    out.println("<td>");
		    testType = (rset.getString(5)).trim();
		    out.println(testType);
		    out.println("</td>");
		    out.println("<td>");
		    pDate = rset.getDate(6).toString().trim();
		    out.println(pDate);
		    out.println("</td>");
		    out.println("<td>");
		    tDate = rset.getDate(7).toString().trim();
		    out.println(tDate);
		    out.println("</td>");
		    out.println("<td>");
		    diagnosis = (rset.getString(8)).trim();
		    out.println(diagnosis);
		    out.println("</td>");
		    out.println("<td>");
		    desc = (rset.getString(9)).trim();
		    out.println(desc);
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
