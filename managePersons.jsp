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
	//select and collect all the persons names
	Statement stmt = null;
	ResultSet rset = null;
	ArrayList personID = new ArrayList();
	ArrayList personName = new ArrayList();
	String sql = "SELECT person_id, CONCAT(first_name, CONCAT(' ', last_name)) FROM persons";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
		while(rset.next())
		{
		    personID.add(rset.getInt(1));
		    personName.add(rset.getString(2).trim());
;		}
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
	<form name="userForm1" action="editPersons.jsp" method="POST" role="form">
		<h1>Manage People</h1>
		Edit Person:
		<br>
		<select name="PERSONID" style="width:220px">
		<%
			for(int i = 0;i < personName.size(); i++)
			{
				out.println("<option value=" + personID.get(i) + ">" + personName.get(i) + "</option>");
			}
		%>
		</select>
		<input type="submit" value="Select Person"/>
	</form>
		<form name="userForm2" action="editPersons.jsp" method="POST" role="form">
		<br>
		Add Person:
		<br>
		<input type="submit" value="Add New Person"/>
	</form>
</div>
</body>
</html>
	
