<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%
	int personID = Integer.parseInt(request.getParameter("personId").trim());

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%

	//select the table from the underlying db and validate the user name and password
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	ResultSet rset1 = null;
	ResultSet rset2 = null;
	ResultSet rset3 = null;
        String sql1 = "SELECT * FROM USERS WHERE person_id = '" + personID + "'";
        String sql2 = "SELECT * FROM PERSONS WHERE person_id = '" + personID + "'";
	String sql3 = "SELECT * FROM FAMILY_DOCTOR WHERE PATIENT_ID = '" +personID + "' OR doctor_id ='" + personID + "'";
	try
	{
	    stmt1 = conn.createStatement();
	    stmt2 = conn.createStatement();
	    stmt3 = conn.createStatement();
	    rset1 = stmt1.executeQuery(sql1);
	    rset2 = stmt2.executeQuery(sql2);
            rset3 = stmt3.executeQuery(sql3);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	String userId = "";
	String pswd = "";
	String cls = "";
	String date = "";
	String firstName = "";
	String lastName = "";
	String address = "";
	String email = "";
	String phone = "";
	ArrayList doc_id = new ArrayList();
	while (rset1 != null && rset1.next())
	{
	    userId = (rset1.getString(1)).trim();
	    pswd = (rset1.getString(2)).trim();
            cls = (rset1.getString(3)).trim();
	    date = (rset1.getString(5)).trim();
	}

	while (rset2 != null && rset2.next())
	{
	    firstName = (rset2.getString(2)).trim();
	    lastName = (rset2.getString(3)).trim();
	    address = (rset2.getString(4)).trim();
	    email = (rset2.getString(5)).trim();
	    phone = (rset2.getString(6)).trim();
	}

	try
	{
	    conn.close();
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	};
%>

<div class="container">
	<form name="userForm" action="AdminupdateUser.jsp" method="post" class="form-signin" role="form">
		<h1 class="form-signin-headin">User Info</h1>
		<input type="hidden" name = "personId" value = "<%out.println(personID);%>" required>
		<input type="text" name="userId" class="form-control" placeholder="userId" value = "<%out.println(userId);%>" required>
		<input type="text" name="NEWPSW1" class="form-control" placeholder="pswd" value = "<%out.println(pswd);%>" required>
		<input type="submit" value="Update" class="btn btn-lg btn-primary btn-block">
	</form>
	<form name="personForm" action="AdminupdatePerson.jsp" method="post" class="form-signin" role="form">
		<h1 class="form-signin-heading">Person Info</h1>
		<input type="hidden" name = "personId" value = "<%out.println(personID);%>" required>
		<input type="text" name="FIRSTNAME" class="form-control" placeholder="First Name" value="<% out.println(firstName); %>" required>
		<input type="text" name="LASTNAME" class="form-control" placeholder="Last Name" value="<% out.println(lastName); %>" required>
		<input type="text" name="ADDRESS" class="form-control" placeholder="Address" value="<% out.println(address); %>" required>
		<input type="text" name="EMAIL" class="form-control" placeholder="Email" value="<% out.println(email); %>" required>
		<input type="text" name="PHONE" class="form-control" placeholder="Phone (XXX-XXX-XXXX)" value="<% out.println(phone); %>" required>
		<input type="submit" value="Update" class="btn btn-lg btn-primary btn-block">
	</form>

		<h1 class="form-signin-heading">Family Doctor Info</h1>
		<%
			for(int i=0;i < doc_id.size();i++){
				out.println("	<form name=\"FmldocForm\" action=\"AdminupdateDoc.jsp\" method=\"get\" class=\"form-updateuser\" role=\"form\">");
				out.println("<input type=\"text\" name=\"docId\" value = \""+doc_id.get(i)+"\">"+doc_id.get(i)+"<br/>");
				out.println("<input type=\"submit\" name=\"Update\" class=\"btn btn-lg btn-primary btn-block\">Update</button></form>");
			}
		%>

</div>
</body>
</html>