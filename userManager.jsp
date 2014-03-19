<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Arraylist" %>
<%@ page import="java.util.List" %>
<%
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%	
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "SELECT * FROM USERS";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	List userId = "";
	List pswd = "";
	List FstName = "";
	List LstName = "";
	int count = -1;
	while (rset != null && rset.next())
	{
	    count += 1;
	    userId.add((rset.getString(0)).trim());
	    pswd.add((rset.getString(1)).trim());
	    FstName.add((rset.getString(2)).trim());
	    LstName.add((rset.getString(3)).trim());
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
	<form name="userList" action="/update/" method="post" class="form-signin" role="form">
		<h1 class=\"form-signin-heading\">User List</h1>
		<ul>
		<%
		while(count!=-1){
			out.println("<li>"+userId.get(count)+"  "+pswd.get(count)+"  "+Fstname.get(count)+"  "+LstName.get(count));
			count -= 1;
		}
		%>
		</ul>
		<button type="submit" name="Submit" class="btn btn-lg btn-primary btn-block">Update</button>
	</form>
</div>
</body>
</html>
	
