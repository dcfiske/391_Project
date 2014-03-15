<%@ page import="java.sql.*" %>
<%
<<<<<<< HEAD
    if (request.getParameter("Submit") != null)
    {
        String myUSR = "shuxiao";
        String myPWD = "4A2y3uram";
=======
	if (request.getParameter("Submit") == null)
	    response.sendRedirect("login.jsp");
>>>>>>> e5944a408128198a1671e1472a84b8b620b7781e

	//get the user input from the login page
	String userName = (request.getParameter("USERID")).trim();
	String passwd = (request.getParameter("PASSWD")).trim();

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "SELECT password, class, person_id FROM users " +
				 "WHERE user_name = '" + userName + "'";
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	String truepwd = "";
	String userClass = "";
	int personID = 0;
	
	while (rset != null && rset.next())
	{
	    truepwd = (rset.getString(1)).trim();
	    userClass = (rset.getString(2)).trim();
	    personID = rset.getInt(3);
	}
	
	try
	{
	    conn.close();
	} catch (Exception ex)
	{
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	//check for a match
	if (passwd.equals(truepwd))
	{
	    session.setAttribute("class", userClass);
	    session.setAttribute("id", personID);
	 response.sendRedirect("home.jsp");
	}
	else
	 response.sendRedirect("login.jsp?error=InvalidLogin");
%>