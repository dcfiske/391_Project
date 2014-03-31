<% String pageName = "analysis"; %>
<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	Statement stmt = null;
	ResultSet rset = null;	
	String patient = request.getParameter("PATIENTID").trim();
	String testType = request.getParameter("TESTTYPE").trim();
	String hia = request.getParameter("TIME").trim();
	String year = request.getParameter("YEAR").trim();
	int check1 = 0;
	int check2 = 3;
	ArrayList patientNames = new ArrayList();
	ArrayList testTypes = new ArrayList();
	ArrayList weeks = new ArrayList();
	ArrayList months = new ArrayList();
	ArrayList years = new ArrayList();
	ArrayList nums = new ArrayList();
	//out.println("<hr>"+patient+","+testType+","+hia+","+year+"<hr>");
	String NUM = "PATIENT_NUM_IMAGE2";
	String TIM = "TIME_ID";
	String PER = "PERSONS";
	String PAT = "PATIENT_ID";
	String TES = "TEST_TYPE";
	String sql = "SELECT ";
	if(!patient.equals("NONE"))
	{	
		check1 += 1;
		sql = sql + "CONCAT(p.first_name, CONCAT(' ', p.last_name)) as name,";
	}
	if(!testType.equals("NONE"))
	{
		check1 += 2;
		if(testType.equals("ALL")){
		sql = sql + TES+ ".TEST_TYPE,";
		}else{
			sql = sql + NUM + ".TEST_TYPE,";
		}
	}
	//sql = sql + TIM + ".TIME_ID,";
	if(hia.equals("WEEK")){
		check2 = 1;
	sql = sql + TIM + ".WEEK AS week,";
	}
	else if(hia.equals("MONTH")){
		check2 = 2;
		sql = sql + TIM + ".MONTH AS month,"; 
	}
	sql = sql + TIM + ".YEAR AS year," + "SUM("+NUM+".NUM) ";
	sql = sql + "FROM " + NUM + "," + TIM;
	if(!patient.equals("NONE"))
	{
		sql = sql + "," + PER + " p,PATIENT p2 ";
	}
	if(!testType.equals("NONE"))
	{
		if(testType.equals("ALL")){
			sql = sql + "," + TES;
		}
	}
	sql = sql + " WHERE ";
	if(!patient.equals("NONE")){
		sql = sql + "p.person_id = p2.PATIENT_ID AND p2.PATIENT_ID = " + NUM + ".PATIENT_ID AND ";
		if(!patient.equals("ALL")){
			sql = sql + "p2.PATIENT_ID = " + patient + " AND ";
		}
	}
	if(!testType.equals("NONE")){
		if(testType.equals("ALL")){
			sql = sql + TES + ".TEST_TYPE = " +NUM + ".TEST_TYPE AND ";
		}else{
			sql = sql + NUM+".TEST_TYPE = '" + testType + "' AND ";
		}
	}
	if(!year.equals("ALL")){
		sql = sql + TIM + ".YEAR =" + year + " AND ";
	}
	sql = sql + TIM+ ".TIME_ID =" +NUM + ".TIME_ID ";
	sql = sql + "GROUP BY ";
	if(!patient.equals("NONE"))
	{
		sql = sql + "CONCAT(p.first_name, CONCAT(' ', p.last_name)),";
	}
	if(!testType.equals("NONE"))
	{
		if(testType.equals("ALL")){
		sql = sql + TES+ ".TEST_TYPE,";
		}else{
			sql = sql + NUM + ".TEST_TYPE,";
		}
	}
	//sql = sql + TIM + ".TIME_ID,";
	if(hia.equals("WEEK")){
	sql = sql + "week,";
	}
	else if(hia.equals("MONTH")){
		sql = sql  + " month,"; 
	}
	sql = sql +  "year ORDER BY ";
	if(check2 == 1){
		sql = sql + "week";
	}else if(check2 == 2){
		sql = sql + "month";
	}else{
		sql = sql + "year ";
	}
	out.println("<hr>"+sql+"<hr>");
	out.println("<div class=\"container\">");
	out.println("<h1>Results</h1>");
	out.println("<table class=\"table table-bordered\">");
	out.println("<tr class=\"active\">");
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
		if(check1 == 1 && check2 == 1){
		//
			out.println("<th>Patient</th>");
			out.println("<th>Week</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 2 && check2 == 1){
		//
			out.println("<th>Test Type</th>");
			out.println("<th>Week</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 3 && check2 == 1){
		//
			out.println("<th>Patient</th>");
			out.println("<th>Test Type</th>");
			out.println("<th>Week</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(5)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 1 && check2 == 2){
			//
			out.println("<th>Patient</th>");
			out.println("<th>Month</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 2 && check2 == 2){
		//			
			out.println("<th>Test Type</th>");
			out.println("<th>Month</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 3 && check2 == 2){
			//
			out.println("<th>Patient</th>");
			out.println("<th>Test Type</th>");
			out.println("<th>Month</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(4)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(5)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		}else if(check1 == 1 && check2 == 3){
			//
			out.println("<th>Patient</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("</tr>");
			}	
		}else if(check1 == 2 && check2 == 3){
			//
			out.println("<th>Test Type</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
				out.println("<tr>");
			    out.println("<td>");
				out.println((rset.getString(1)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(2)).trim());
				out.println("</td>");
				out.println("<td>");
				out.println((rset.getString(3)).trim());
				out.println("</td>");
				out.println("</tr>");
			}
		
		}else if(check1 == 3 && check2 == 3){
			//
			out.println("<th>Patient</th>");
			out.println("<th>Test Type</th>");
			out.println("<th>Year</th>");
			out.println("<th>Number of Image</th>");
			while(rset!=null&&rset.next()){
					out.println("<tr>");
				    out.println("<td>");
					out.println((rset.getString(1)).trim());
					out.println("</td>");
					out.println("<td>");
					out.println((rset.getString(2)).trim());
					out.println("</td>");
					out.println("<td>");
					out.println((rset.getString(3)).trim());
					out.println("</td>");
					out.println("<td>");
					out.println((rset.getString(4)).trim());
					out.println("</td>");
					out.println("</tr>");
			}
		}
		out.println("</table>");
		out.println("</div>");
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

</body>
</html>

