<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*" %>
<%
	if (request.getParameter("Submit") == null)
	        response.sendRedirect("home.jsp");
        
	int personID = (Integer) session.getAttribute("id");
	
	//get user's input from the upload.jsp page
	int patId = Integer.parseInt((request.getParameter("PATIENTID")).trim());
	int docId = Integer.parseInt((request.getParameter("DOCTORID")).trim());
	String testType = (request.getParameter("TESTTYPE")).trim();
	String prescribe = (request.getParameter("PRESCRIBE")).trim();
        String testDate = (request.getParameter("TESTDATE")).trim();
        String diagnosis = (request.getParameter("DIAGNOSIS")).trim();
        String description = (request.getParameter("DESCRIPTION")).trim();

	
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//insert the radiology record into table
	Statement stmt = null;
	ResultSet rset = null;
	int recId = 0;
	            
        try
	{
	    stmt = conn.createStatement();
	    ResultSet rset1 = stmt.executeQuery("SELECT record_id_sequence.nextval from dual");
	    rset1.next();
	    recId = rset1.getInt(1);
	    String sql = "INSERT into radiology_record VALUES ('" + recId + "', '" + patId + "', '" + docId + "', '" + personID + "', '" + testType + "', '" + prescribe + "', '" + testDate + "', '" + diagnosis + "', '" + description + "')";
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
	 
	session.setAttribute("recordId", recId);
%>


<div class="container">
	<h1 class=\"form-signin-heading\">
	<center>Radiology Record Successfully Entered <br> <br> Upload Image for this record? </center>
	</h1>
	<form name="uploadImage" method="POST" enctype="multipart/form-data" action="uploadImage">
		<center>
			<table>
			  <tr>
			    <th> File path:</th>
			    <td><input name="file-path" type="file" size="40"></input></td>
			  </tr>
			  <br>
			  <tr>
			    <td><input type="submit" name=".submit" value="Upload"></td>
			  </tr>
			</table>
		</center>
	</form>
</div>
</body>
</html>
