<% String pageName = "manage"; %>
<%@ include file="menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    function checkPWD()
    {
        if (document.userForm.NEWPWD.value != document.userForm.NEWPWD2.value)
        {
        	alert("The passwords do not match. Try again.");
            return false;
        }
        else
            return true;
    }
</SCRIPT>
<%@ page import="java.sql.*"%>
<div class="container">
	<form name="userForm" onsubmit="return checkPWD()" action="updateUsers.jsp" method="post" role="form">
		<h1>User Info</h1>
<%
	String userName = "";

	if (request.getParameter("USERNAME") == null)
	{
	    out.println("Username:<br>");
	    out.println("<input type=\"text\" name=\"USR\" size=\"25\" maxlength=\"24\" required>");
	    out.println("<br>Class:<br>");
	    out.println("<select name=\"CLASS\">");
	    out.println("<option value=\"a\">Admin</option>");
	    out.println("<option value=\"d\">Doctor</option>");
	    out.println("<option value=\"r\">Radiologist</option>");
	    out.println("<option value=\"p\">Patient</option>");
	    out.println("</select>");
	    out.println("<br>Person<br>");
	    out.println("<select name=\"PERSON\">");
	    
		//establish the connection to the underlying database
		Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
		//select the user table from the underlying db and validate the user name and password
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "SELECT person_id, CONCAT(first_name, CONCAT(' ', last_name)) FROM persons";
		
		try
		{
		    stmt = conn.createStatement();
		    rset = stmt.executeQuery(sql);
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		int personID = 0;
		String personName = "";
		
		while (rset != null && rset.next())
		{
		    personID = rset.getInt(1);
		    personName = rset.getString(2).trim();
		    out.println("<option value=" + personID + ">" + personName + "</option>");
		}
		
		try
		{
		    conn.close();
		} catch (Exception ex)
		{
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		out.println("</select><br>");
	}
	else
	{
		userName = request.getParameter("USERNAME").trim();
		out.println("<input type=\"hidden\" name=\"USR\" value=" + userName + " required>");
	}
%>
		New Password:
		<br>
		<input type="password" name="NEWPWD" size="25" maxlength="24" required>
		<br>
		Confirm Password:
		<br>
		<input type="password" name="NEWPWD2" size="25" maxlength="24" required>
		<br>
		<button type="submit" name="Submit">Update</button>
	</form>
</div>
</body>
</html>
