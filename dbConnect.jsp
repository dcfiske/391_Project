<%
	String myUSR = "";
	String myPWD = "";
	
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gynne.cs.ualberta.ca:1521:CRS";
	
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
%>
