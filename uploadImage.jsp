<%@ include file="menu.jsp" %>

<%
    int personID = (Integer) session.getAttribute("id");
    int recID = (Integer) session.getAttribute("recordId");
    
%>
<div class="container">
	<h1 class=\"form-signin-heading\">
	<center>Image Successfully uploaded <br> <br> Upload another Image for this record? </center>
	</h1>
	<form name="uploadImage" method="POST" enctype="multipart/form-data" action="uploadImage">
	<table>
	  <tr>
	    <th>File path: </th>
	    <td><input name="file-path" type="file" size="30" ></input></td>
	  </tr>
	  <tr>
	    <td ALIGN=CENTER COLSPAN="2"><input type="submit" name=".submit"
	    class="btn btn-lg btn-primary btn-block" value="Upload"></td>
	  </tr>
	</table>
	</form>
</div>
</body>
</html>
