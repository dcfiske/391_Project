<% String pageName = "myinfo"; %>
<%@ include file="menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    function checkPWD()
    {
        if (document.personForm2.NEWPWD1.value != document.personForm2.NEWPWD2.value)
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
		<input type="text" name="FIRSTNAME" placeholder="First Name" value="<% out.println(firstName); %>" required>
		<input type="text" name="LASTNAME" placeholder="Last Name" value="<% out.println(lastName); %>" required>
		<input type="text" name="ADDRESS" placeholder="Address" value="<% out.println(address); %>" required>
		<input type="text" name="EMAIL" placeholder="Email" value="<% out.println(email); %>" required>
		<input type="text" name="PHONE" placeholder="Phone (XXX-XXX-XXXX)" value="<% out.println(phone); %>" required>
		<button type="submit" name="Submit">Update</button>
	</form>
	<form name="personForm2" onsubmit="return checkPWD()" action="updateUsers.jsp" method="post" role="form">
		<h1>Change Password</h1>
		<input type="password" name="NEWPWD1" placeholder="New Password" required>
		<input type="password" name="NEWPWD2" placeholder="New Password" required>
		<button type="submit" name="Submit">Update</button>
	</form>
</div>
</body>
</html>
