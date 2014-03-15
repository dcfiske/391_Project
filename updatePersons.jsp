<%@ page import="java.sql.*" %>
<%
<<<<<<< HEAD
    if (request.getParameter("Submit") != null)
    {
	int personID = (Integer) session.getAttribute("id");
        String myUSR = "shuxiao";
        String myPWD = "4A2y3uram";

        //get the user input from the info page
        String firstName = (request.getParameter("FIRSTNAME")).trim();
        String lastName = (request.getParameter("LASTNAME")).trim();
        String address = (request.getParameter("ADDRESS")).trim();
        String email = (request.getParameter("EMAIL")).trim();
        String phone = (request.getParameter("PHONE")).trim();

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
        String sql = "UPDATE persons SET first_name = '" + firstName + "', " +
                						 "last_name = '" + lastName + "', " +
                						 "address = '" + address + "', " +
                						 "email = '" + email + "', " +
                						 "phone = '" + phone + "' " +
                	 "WHERE person_id = '" + personID + "'";
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
	    
        response.sendRedirect("myinfo.jsp");
    } else
    {
        response.sendRedirect("login.jsp");
    }
%>
=======
    if (request.getParameter("Submit") == null)
        response.sendRedirect("login.jsp");
        
	int personID = (Integer) session.getAttribute("id");
	
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
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;
	String sql = "UPDATE persons SET first_name = '" + firstName + "', " +
	        						 "last_name = '" + lastName + "', " +
	        						 "address = '" + address + "', " +
	        						 "email = '" + email + "', " +
	        						 "phone = '" + phone + "' " +
	        	 "WHERE person_id = '" + personID + "'";
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
	
	response.sendRedirect("myinfo.jsp");
%>
>>>>>>> e5944a408128198a1671e1472a84b8b620b7781e
