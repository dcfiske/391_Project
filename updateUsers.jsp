<%@ page import="java.sql.*" %>
<%
	if (request.getParameter("Submit") == null)
	    response.sendRedirect("login.jsp");
    
	String userName = "";
	String userPwd = request.getParameter("NEWPWD").trim();
	String userClass = "";
	int personID = 0;
	String redirect = "manageUsers.jsp";
	
	if (request.getParameter("CLASS") != null)
	{
	    // new user
	    userName = request.getParameter("USR").trim();
	    userClass = request.getParameter("CLASS").trim();
	    personID = Integer.parseInt(request.getParameter("PERSON").trim());
	}
	else if (request.getParameter("USR") != null)
	{
	    // update user
	    userName = request.getParameter("USR").trim();
	}
	else
	{
	    // update my info
		userName = (String) session.getAttribute("usr");
	    redirect = "myinfo.jsp";
	}
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	stmt = conn.createStatement();
	String sql = "";
	
	if (personID > 0)
	{   
		sql = "INSERT INTO users VALUES ('" + userName + "', '" + 
											    userPwd + "', '" +
										        userClass + "', '" +
									            personID + "', SYSDATE)";
	}
	else
	{
		sql = "UPDATE users SET password = '" + userPwd + "' WHERE user_name = '" + userName + "'";
	}
	
	try
	{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
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
	
	response.sendRedirect(redirect);
%>
