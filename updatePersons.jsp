<%@ page import="java.sql.*" %>
<%
	if (request.getParameter("Submit") == null)
	    response.sendRedirect("login.jsp");
	
	String redirect = "managePersons.jsp";
	
	if (request.getParameter("Submit").trim().equals("myinfo")){
		redirect = "myinfo.jsp" ;
	}
    
	int personID;
	
	if (request.getParameter("ID") != null)
	    personID = Integer.parseInt(request.getParameter("ID").trim());
	else
		personID = (Integer) session.getAttribute("id");
	
	//get the user input from the info page
	String firstName = (request.getParameter("FIRSTNAME")).trim();
	String lastName = (request.getParameter("LASTNAME")).trim();
	String address = (request.getParameter("ADDRESS")).trim();
	String email = (request.getParameter("EMAIL")).trim();
	String phone = (request.getParameter("PHONE")).trim();
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//update the person's info after clicking the Update button
	Statement stmt = null;
	ResultSet rset = null;
	stmt = conn.createStatement();
	String sql = "";
	
	if (personID > 0)
	{
		sql = "UPDATE persons SET first_name = '" + firstName + "', " +
		        						 "last_name = '" + lastName + "', " +
		        						 "address = '" + address + "', " +
		        						 "email = '" + email + "', " +
		        						 "phone = '" + phone + "' " +
		        	 "WHERE person_id = '" + personID + "'";
	}
	else
	{
	    rset = stmt.executeQuery("SELECT person_id_sequence.nextval from dual");
	    rset.next();
	    personID = rset.getInt(1);
	    
		sql = "INSERT INTO persons VALUES ('" + personID + "', '" + 
													  firstName + "', '" +
												      lastName + "', '" +
											          address + "', '" +
											          email + "', '" +
											          phone + "')";
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
