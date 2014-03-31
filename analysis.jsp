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
	ResultSet rset2 = null;
	ResultSet rset3 = null;
	ArrayList patientIDs = new ArrayList();
	ArrayList patientNames = new ArrayList();
	ArrayList testTypes = new ArrayList();
	String sql = "CREATE OR REPLACE FORCE VIEW PATIENT (PATIENT_ID) AS SELECT distinct patient_id FROM radiology_record";
	String sql2 = "CREATE OR REPLACE FORCE VIEW TEST_TYPE (TEST_TYPE) AS SELECT distinct  TEST_TYPE FROM radiology_record ";
	String sql3 = "create or replace VIEW time_id as SELECT  ROW_NUMBER() OVER (ORDER BY year) as time_id,week,month,year as year  FROM (select distinct to_char(TEST_DATE, 'IW') as week,to_char(TEST_DATE, 'MON') as month,to_char(TEST_DATE, 'YY') as year from radiology_record) ";
	String sql4 = "create or replace view patient_number_image as select distinct p.PATIENT_ID,t.TEST_TYPE,COUNT(pi.image_id) as num,ti.time_id "+
	"from PATIENT p, TEST_TYPE t,RADIOLOGY_RECORD rr, PACS_IMAGES pi,TIME_ID ti " +
	"where p.PATIENT_ID = rr.PATIENT_ID AND t.TEST_TYPE = rr.TEST_TYPE AND pi.record_id = rr.record_id AND ti.week = to_char(rr.TEST_DATE,'IW') AND ti.year = to_char(rr.TEST_DATE,'YYYY') GROUP BY p.PATIENT_ID,t.TEST_TYPE,ti.time_id ";
    String sql5 = "DROP TABLE PATIENT_NUM_IMAGE2 ";
    String sql6 = "CREATE TABLE PATIENT_NUM_IMAGE2(PATIENT_ID varchar(24),TEST_TYPE varchar(24),TIME_ID int, NUM int default 0) ";
    String sql7 = "INSERT INTO PATIENT_NUM_IMAGE2 (PATIENT_ID,TEST_TYPE,TIME_ID) SELECT p.PATIENT_ID,t.TEST_TYPE,ti.TIME_ID FROM PATIENT p,TEST_TYPE t,TIME_ID ti ";
   	String sql8 = "Merge into PATIENT_NUM_IMAGE2 p2 USING PATIENT_NUMBER_IMAGE p1 ON (p2.TEST_TYPE = p1.TEST_TYPE AND p2.PATIENT_ID = p1.PATIENT_ID AND p2.TIME_ID = p1.TIME_ID) WHEN MATCHED THEN  UPDATE    SET NUM = P1.NUM";
	String sql9 = "SELECT p.person_id, CONCAT(p.first_name, CONCAT(' ', p.last_name))" +
			 " FROM persons p, PATIENT p2" +
			 " WHERE p.person_id = p2.PATIENT_ID";
	String sql10 = "SELECT t.TEST_TYPE FROM TEST_TYPE t";
	
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	    rset = stmt.executeQuery(sql2);
	    rset = stmt.executeQuery(sql3);
	    rset = stmt.executeQuery(sql4);
	    rset = stmt.executeQuery(sql5);
	    rset = stmt.executeQuery(sql6);
	    rset = stmt.executeQuery(sql7);
	    rset = stmt.executeQuery(sql8);
	    stmt.executeQuery("commit");
	    
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	try
	{
	    rset2 = stmt.executeQuery(sql9);
	    
	} catch (Exception ex)
	{
		out.println("<hr>" + ex.getMessage() + "<hr>");
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	while (rset2 != null && rset2.next())
	{
		
	    patientIDs.add((rset2.getInt(1)));
	    patientNames.add((rset2.getString(2)).trim());
	}
	try
	{
	    rset3 = stmt.executeQuery(sql10);
	    
	} catch (Exception ex)
	{	out.println("<hr>" + ex.getMessage() + "<hr>");
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	   out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	while (rset3 != null && rset3.next())
	{
	    testTypes.add((rset3.getString(1)).trim());
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
	<form name="personForm" action="analysisResult.jsp" method="post"  role="form">
		<h1>Data Analysis Info</h1>
				PATIENT:
		<br>
		<select name="PATIENTID" style="width:220px">
			<option value = "NONE"> NONE </option>
			<option value = "ALL"> ALL </option>
			<%
				for (int i = 0; i < patientIDs.size(); i++)
				{
				    out.println("<option value = " + patientIDs.get(i) + ">" + patientNames.get(i) + "</option>");
				}
			%>
		</select>
		<br>
				TEST_TYPE:
		<br>
		<select name="TESTTYPE" style="width:220px">
			<option value = "NONE"> NONE </option>
			<option value = "ALL"> ALL </option>
			<%
				for (int i = 0; i < testTypes.size(); i++)
				{
				    out.println("<option value = " + testTypes.get(i) + ">" + testTypes.get(i) + "</option>");
				}
			%>
		</select>
		<br>
				TIME HIERARCHY:
		<br>
		<select name="TIME" style="width:220px">
			<option value = "WEEK"> WEEKLY </option>
			<option value = "MONTH"> MONTHLY </option>
			<option value = "YEAR">  YEARLY </option>
		</select>
		 Year:
 	 		<select id="YEAR" name="YEAR" />
 	 		<option value = "ALL">ALL</option>
 	 <%String j = "";
   	 for(int i=1900;i<2026;i++)
    	{
	 	 j = Integer.toString(i);
	  	out.println("<option value = \""+j+"\">"+i+"</option>");
   		 }
	  %>      
  </select>
		<br>
		<br>
		<br>
		<button type="submit" name="Submit">START GENERATION</button>
	</form>
</div>
</body>
</html>