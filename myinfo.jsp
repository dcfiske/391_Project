<% String pageName = "myinfo"; %>
<%@ include file="menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    function checkPWD()
    {
        if (document.personForm2.NEWPWD.value != document.personForm2.NEWPWD2.value)
        {
        	alert("The passwords do not match. Try again.");
            return false;
        }
        else
            return true;
    }
</SCRIPT>
<%@ page import="java.sql.*"%>
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
	String sql = "SELECT * FROM persons WHERE person_id = '" + personID + "'";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	String firstName = "";
	String lastName = "";
	String address = "";
	String email = "";
	String phone = "";
	
	while (rset != null && rset.next())
	{
	    firstName = (rset.getString(2)).trim();
	    lastName = (rset.getString(3)).trim();
	    address = (rset.getString(4)).trim();
	    email = (rset.getString(5)).trim();
	    phone = (rset.getString(6)).trim();
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
	<form name="personForm1" action="updatePersons.jsp" method="post" role="form">
		<h1>My Info</h1>
		First Name:
		<br>
		<input type="text" name="FIRSTNAME" size="25" maxlength="24" value="<% out.println(firstName); %>" required>
		<br>
		Last Name:
		<br>
		<input type="text" name="LASTNAME" size="25" maxlength="24" value="<% out.println(lastName); %>" required>
		<br>
		Street Address:
		<br>
		<input type="text" name="ADDRESS" size="100" maxlength="128" value="<% out.println(address); %>" required>
		<br>
		Email:
		<br>
		<input type="text" name="EMAIL" size="100" maxlength="128" placeholder="email@domain.com" value="<% out.println(email); %>" required>
		<br>
		Phone:
		<br>
		<input type="text" name="PHONE" size="11" maxlength="10" value="<% out.println(phone); %>" required>
		<br>
		<button type="submit" name="Submit" value = "myinfo">Update</button>
	</form>
	<form name="personForm2" onsubmit="return checkPWD()" action="updateUsers.jsp" method="post" role="form">
		<h1>Change Password</h1>
		New Password:
		<br>
		<input type="password" name="NEWPWD" size="25" maxlength="24" required>
		<br>
		Confirm Password:
		<br>
		<input type="password" name="NEWPWD2" size="25" maxlength="24" required>
		<br>
		<button type="submit" name="Submit" value = "myinfo">Update</button>
	</form>
</div>
</body>
</html>
