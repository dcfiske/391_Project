<% String pageName = "upload"; %>
<%@ include file="menu.jsp" %>

<%
	//this will update the image after clicking the submit
    int personID = (Integer) session.getAttribute("id");
    int recID = (Integer) session.getAttribute("recordId");
    
%>

<div class="container">
	<h1 class=\"form-signin-heading\">
	<center>Image Successfully Uploaded <br> <br> Upload another image for this record? </center>
	</h1>
	<form name="uploadImage" method="POST" enctype="multipart/form-data" action="uploadImage">
		<center>
			<table>
			  <tr>
			    <td><input name="file-path" type="file" size="40"></input></td>
			  </tr>
			  <br>
			  <tr>
			    <td><input type="submit" name=".submit" value="Upload"></td>
			  </tr>
			</table>
		</center>
	</form>
</div>
</body>
</html>
