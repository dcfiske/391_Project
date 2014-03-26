<%@ include file="menu.jsp" %>
<!-- allows the user to enter the radiology record-->
<div class="container">
	<form name="RecordForm" action="uploadRecord.jsp" method="post" class="form-signin" role="form">
		<h1 class=\"form-signin-heading\">Enter Radiology Record</h1>
		<input type="text" name="PATIENTID" class="form-control" placeholder="Patient ID" required>
		<input type="text" name="DOCTORID" class="form-control" placeholder="Doctor ID" required>
		<input type="text" name="TESTTYPE" class="form-control" placeholder="Test Type" required>
		<input type="text" name="PRESCRIBE" class="form-control" placeholder="Prescribing Date (YY-MMM-DD)" required>
		<input type="text" name="TESTDATE" class="form-control" placeholder="Test Date (YY-MMM-DD)" required>
		<input type="text" name="DIAGNOSIS" class="form-control" placeholder="Diagnosis" required>
		<input type="text" name="DESCRIPTION" class="form-control" placeholder="Description" required>
		<button type="submit" name="Submit" class="btn btn-lg btn-primary btn-block">Upload</button>
	</form>
</div>
</body>
</html>