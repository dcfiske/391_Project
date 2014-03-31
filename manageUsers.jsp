<% String pageName = "manager"; %>
<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%	
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	ArrayList userName = new ArrayList();
	String sql = "SELECT user_name FROM users";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
		while(rset.next())
		{
		    userName.add(rset.getString(1).trim());
		}
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
%>
<div class="container">
	<form name="userForm1" action="editUsers.jsp" method="POST" role="form">
		<h1>Manage Users</h1>
		Edit User:
		<br>
		<select name="USERNAME" style="width:220px">
		<%
			for(int i = 0;i < userName.size(); i++)
			{
				out.println("<option value=" + userName.get(i) + ">" + userName.get(i) + "</option>");
			}
		%>
		</select>
		<input type="submit" value="Select User"/>
	</form>
		<form name="userForm2" action="editUsers.jsp" method="POST" role="form">
		<br>
		Add User:
		<br>
		<input type="submit" value="Add New User"/>
	</form>
</div>
</body>
</html>
	
