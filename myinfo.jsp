<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%
	int personID = (Integer) session.getAttribute("id");
	String myUSR = "dfiske";
	String myPWD = "h4shbr0wnz.";
	
	//establish the connection to the underlying database
	Connection conn = null;
	
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	try
	{
	    //load and register the driver
	    Class drvClass = Class.forName(driverName);
	    DriverManager.registerDriver((Driver) drvClass
	            .newInstance());
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	try
	{
	    //establish the connection 
	    conn = DriverManager.getConnection(dbstring, myUSR, myPWD);
	    conn.setAutoCommit(false);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
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
	<form name="personForm" action="updatePersons.jsp" method="post" class="form-signin" role="form">
		<h1 class=\"form-signin-heading\">My Info</h1>
		<input type="text" name="FIRSTNAME" class="form-control" placeholder="First Name" value="<% out.println(firstName); %>" required>
		<input type="text" name="LASTNAME" class="form-control" placeholder="Last Name" value="<% out.println(lastName); %>" required>
		<input type="text" name="ADDRESS" class="form-control" placeholder="Address" value="<% out.println(address); %>" required>
		<input type="text" name="EMAIL" class="form-control" placeholder="Email" value="<% out.println(email); %>" required>
		<input type="text" name="PHONE" class="form-control" placeholder="Phone (XXX-XXX-XXXX)" value="<% out.println(phone); %>" required>
		<button type="submit" name="Submit" class="btn btn-lg btn-primary btn-block">Update</button>
	</form>
</div>
</body>
</html>