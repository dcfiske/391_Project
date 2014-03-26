<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@ page import="oracle.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="javax.imageio.ImageIO"%>

<%@ page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>

<%
    if (request.getParameter("Submit") == null)
	response.sendRedirect("home.jsp");
        
    int personID = (Integer) session.getAttribute("id");
    int recID = (Integer) session.getAttribute("recordId");
    int pic_id;
    
    	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    List FileItems = fu.parseRequest(request);
	        
	    // Process the uploaded items, assuming only 1 image file uploaded
	    Iterator i = FileItems.iterator();
	    FileItem item = (FileItem) i.next();
	    while (i.hasNext() && item.isFormField()) {
		item = (FileItem) i.next();
	    }

	    //Get the image stream
	    InputStream instream = item.getInputStream();

	    BufferedImage img = ImageIO.read(instream);
	    BufferedImage thumbNail = shrink(img, 10);
	
	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	    Statement stmt = conn.createStatement();
	    
	    //First, to generate a unique image_id using an SQL sequence
            
	    ResultSet rset1 = stmt.executeQuery("SELECT image_id_sequence.nextval from dual");
	    rset1.next();
	    pic_id = rset1.getInt(1);

	    //Insert an empty blob into the table first. Note that you have to 
	    //use the Oracle specific function empty_blob() to create an empty blob
	    stmt.execute("INSERT INTO pacs_images VALUES("+recID+","+pic_id+",empty_blob(),empty_blob(),empty_blob())");
 
	    // to retrieve the lob_locator 
	    // Note that you must use "FOR UPDATE" in the select statement
	    String cmd = "SELECT * FROM pacs_images WHERE image_id = "+pic_id+" AND record_id = "+recID+" FOR UPDATE";
	    ResultSet rset = stmt.executeQuery(cmd);
	    rset.next();
	    BLOB imgblob = ((OracleResultSet)rset).getBLOB(3);
            BLOB imgblob2 = ((OracleResultSet)rset).getBLOB(4);
	    BLOB imgblob3 = ((OracleResultSet)rset).getBLOB(5);



	    //Write the image to the blob object
	    OutputStream outstream = imgblob.getBinaryOutputStream();
	    ImageIO.write(thumbNail, "jpg", outstream);
            
            OutputStream outstream = imgblob2.getBinaryOutputStream();
	    ImageIO.write(img, "jpg", outstream);
            
            OutputStream outstream = imgblob3.getBinaryOutputStream();
	    ImageIO.write(img, "jpg", outstream);
	    
	    instream.close();
	    outstream.close();

            stmt.executeUpdate("commit");
            conn.close();

	} catch( Exception ex ) {
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}

	//Output response to the client
	response.setContentType("text/html");
	PrintWriter out = response.getWriter();
	out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
		    "Transitional//EN\">\n" +
		    "<HTML>\n" +
		    "<HEAD><TITLE>Upload Message</TITLE></HEAD>\n" +
		    "<BODY>\n" +
		    "<H1>" +
		            response_message +
		    "</H1>\n" +
		    "</BODY></HTML>");
    }
    
    public static BufferedImage shrink(BufferedImage image, int n) {

    int w = image.getWidth() / n;
    int h = image.getHeight() / n;

    BufferedImage shrunkImage =
        new BufferedImage(w, h, image.getType());

    for (int y=0; y < h; ++y)
        for (int x=0; x < w; ++x)
            shrunkImage.setRGB(x, y, image.getRGB(x*n, y*n));

    return shrunkImage;
    }
%>

<%@ include file="dbConnect.jsp" %>

<--CREATE TABLE pacs_images (
   record_id   int,
   image_id    int,
   thumbnail   blob,
   regular_size blob,
   full_size    blob,
   PRIMARY KEY(record_id,image_id),
   FOREIGN KEY(record_id) REFERENCES radiology_record
);-->