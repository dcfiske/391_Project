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
	ArrayList userId = new ArrayList();
	ArrayList personId = new ArrayList();
	String sql = "SELECT * FROM USERS";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	while(rset.next()){
		userId.add((rset.getString(1)).trim());
		personId.add((rset.getString(4)).trim());
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
	<form name="personForm1" action="Adminupdate.jsp" method="get" class="form-updateuser" role="form">
		<h1 class=\"form-signin-heading\">User List</h1>
		<%
			for(int i=0;i < userId.size();i++){
				out.println("<input type=\"radio\" name=\"personId\" value = "+personId.get(i)+">"+userId.get(i)+"<br/>");
			}
		%>
	<input type="submit" value="Enter"/>
	</form>
</div>
</body>
</html>
	
