<% String pageName = "reports"; %>
<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	String diag = request.getParameter("diagnosis").trim();
	String startM = request.getParameter("month_start").trim();
	String startD = request.getParameter("day_start").trim();
	String startY = request.getParameter("year_start").trim();
	String endM = request.getParameter("month_end").trim();
	String endD = request.getParameter("day_end").trim();
	String endY = request.getParameter("year_end").trim();
	String start = startD + "-" + startM + "-" + startY;
	String end = endD + "-" + endM + "-" + endY;

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	Statement stmt = null;
	ResultSet rset = null;
	ArrayList fName = new ArrayList();
	ArrayList lName = new ArrayList();
	ArrayList address = new ArrayList();
	ArrayList phone = new ArrayList();
	ArrayList date = new ArrayList();
	//generate the list of the name,address,phone and the earliest date that they did the test.
	String sql = "SELECT p.first_name, p.last_name, p.ADDRESS, p.phone, TO_CHAR(MIN(r.test_date), 'DD-MON-YYYY')" +
				 " FROM persons p, radiology_record r" +
				 " WHERE p.person_id = r.patient_id AND CONTAINS(r.diagnosis, '" + diag + "', 1) > 0" +
				 " AND r.test_date >= '" + start + "' AND r.test_date <='" + end + "'" +
				 " GROUP BY p.first_name, p.last_name, p.address, p.phone";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	    while(rset!=null&&rset.next())
	    {
	    	fName.add(rset.getString(1).trim());
	    	lName.add(rset.getString(2).trim());
	    	address.add(rset.getString(3).trim());
	    	phone.add(rset.getString(4).trim());
	    	date.add(rset.getString(5).trim());
	    }
	}
	catch (Exception ex)
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
%>
<div class="container">
	<h1>Patient Info</h1>
	<table class="table table-bordered">
		<tr class="active">
			<th>Name</th>
			<th>Address</th>
			<th>Phone</th>
			<th>Test Date</th>
		</tr>
		<%
			for(int i = 0; i < fName.size(); i++)
			{
			    out.println("<tr>");
			    out.println("<td>" + fName.get(i) + " " + lName.get(i) + "</td>");
			    out.println("<td>" + address.get(i) + "</td>");
			    out.println("<td>" + phone.get(i) + "</td>");
			    out.println("<td>" + date.get(i) + "</td>");
			    out.println("</tr>");
				//out.println("<li>  "+ fName.get(i) + " " + lName.get(i) + ",  " + address.get(i) + " " + phone.get(i) + "    " + date.get(i) + "</li>");
			}
		%>
	</table>
	<form name="backForm" method="post" action="reports.jsp" role="form">
		<button type="submit">Back</button>
	</form>
</div>
</body>
</html>		