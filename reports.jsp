<% String pageName = "reports"; %>
<%@ include file="menu.jsp" %>
<%@page import = "java.util.*" %>
<div class="container">
	<form name="personForm" action="generation.jsp" method="post"  role="form">
		<h1>Report Generation</h1>
		DIAGNOSIS:
		<br>
		<input type="text" name="diagnosis" size="100" maxlength="128" required>
		<br><br>
		FROM:
		<br>
		<label for="month_start">Month</label>
		<select id="month_start" name="month_start"/>
			<option value = "JAN">January</option>      
			<option value = "FEB">February</option>      
			<option value = "MAR" >March</option>      
			<option value = "APR">April</option>      
			<option value = "MAY">May</option>      
			<option value = "JUN">June</option>      
			<option value = "JUL">July</option>      
			<option value = "AUG">August</option>      
			<option value = "SEPT">September</option>      
			<option value = "OCT">October</option>      
			<option value = "NOV">November</option>      
			<option value = "DEC">December</option>      
		</select> 
		<label for="day_start">Day</label>
		<select id="day_start" name="day_start"/>
		<%
			for (int i = 1; i < 32; i++)
			{
				out.println("<option value=\"" + i + "\">" + i + "</option>");
			}
		%>   
		</select>
		<label for="year_start">Year</label>
		<select id="year_start" name="year_start"/>
		<%
			for (int i = 1900; i < 2016; i++)
			{
				out.println("<option value=\"" + i + "\">" + i + "</option>");
			}
		%>
		</select>
		<br><br>
		TO:
		<br>
		<label for="month_end">Month</label>
		<select id="month_end" name="month_end"/>
			<option value = "JAN">January</option>      
			<option value = "FEB">February</option>      
			<option value = "MAR" >March</option>      
			<option value = "APR">April</option>      
			<option value = "MAY">May</option>      
			<option value = "JUN">June</option>      
			<option value = "JUL">July</option>      
			<option value = "AUG">August</option>      
			<option value = "SEPT">September</option>      
			<option value = "OCT">October</option>      
			<option value = "NOV">November</option>      
			<option value = "DEC">December</option>    
		</select>
		<label for="day_end">Day</label>
		<select id="day_end" name="day_end"/>
		<%
			for (int i = 1; i < 32; i++)
			{
				out.println("<option value=\"" + i + "\">" + i + "</option>");
			}
		%>   
		</select>
		<label for="year_end">Year</label>
		<select id="year_end" name="year_end"/>
		<%
			for (int i = 1900; i < 2016; i++)
			{
				out.println("<option value=\"" + i + "\">" + i + "</option>");
			}
		%>   
		</select>
		<br><br>
		<input type="submit" value = "SUBMIT">
	</form>
</div>
</body>
</html>