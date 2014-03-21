<%@ include file="menu.jsp" %>
<%@ page import="java.sql.*"%>
<%
	int personID = (Integer) session.getAttribute("id");

	//establish the connection to the underlying database
	Connection conn = null;
%>
<%@ include file="dbConnect.jsp" %>
<%
	//select the user table from the underlying db and validate the user name and password
	Statement stmt = null;
	ResultSet rset = null;

