<%
	String myUSR = "dfiske";
	String myPWD = "h4shbr0wnz.";
	
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@localhost:1525:CRS";
	
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
