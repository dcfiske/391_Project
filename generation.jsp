<% String pageName = "reports"; %>
<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	String Diag = request.getParameter("diagnosis").trim();
	String startm = request.getParameter("month_start").trim();
	String startd = request.getParameter("day_start").trim();
	String starty = request.getParameter("year_start").trim();
	String endm = request.getParameter("month_end").trim();
	String endd = request.getParameter("day_end").trim();
	String endy = request.getParameter("year_end").trim();
	String start = startd +"-" + startm + "-" +starty;
	String end = endd + "-" +endm + "-" + endy;

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//coeect the name,and infos according to the specific diagnosis and date
	Statement stmt = null;
	ResultSet rset = null;
	ArrayList Fname = new ArrayList();
	ArrayList Lname = new ArrayList();
	ArrayList address = new ArrayList();
	ArrayList phone = new ArrayList();
	ArrayList date = new ArrayList();
	String sql = "SELECT p.FIRST_NAME,p.LAST_NAME,p.ADDRESS,p.PHONE,MIN(r.TEST_DATE) FROM PERSONS p,RADIOLOGY_RECORD r	WHERE p.PERSON_ID = r.PATIENT_ID  AND r.DIAGNOSIS = '"+Diag+"' AND r.TEST_DATE >= '"+start+"'  AND r.TEST_DATE <='"+end+"' GROUP BY p.FIRST_NAME,p.LAST_NAME,p.ADDRESS,p.PHONE";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	    while(rset!=null&&rset.next()){
	    	Fname.add(rset.getString(1).trim());
	    	Lname.add(rset.getString(2).trim());
	    	address.add(rset.getString(3).trim());
	    	phone.add(rset.getString(4).trim());
	    	date.add(rset.getString(5).trim().substring(0,10));
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
	<form name="userForm" action="reports.jsp" method="post" role="form">
		<h1>Generation Info</h1>
		<table class=table table-bordered>
		<tr class="active">
		<th>First Name</th>
		<th>Last Name</th>
		<th>Address</th>
		<th>Phone</th>
		<th>Date</th>
			<%
			for(int i = 0; i < Fname.size(); i++){
				out.println("<tr><td>"+ Fname.get(i) + "</td><td>" + Lname.get(i) + "</td><td>" + address.get(i) + "</td><td>" + phone.get(i) + "</td><td>" + date.get(i) + "</tr>");
				}
			%>
			<button> Back </button>
	</table>
	</form>
	</div>
</body>
</html>		