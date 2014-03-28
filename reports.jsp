<% String pageName = "reports"; %>
<%@ include file="menu.jsp" %>
<%@page import = "java.util.*" %>
<div class="container">
	<form name="personForm" action="generation.jsp" method="post"  role="form">
		<h1 class="form-signin-heading">Report Generation Info</h1>
		<legend>Diagnosis</legend>
		<input type="text" name="diagnosis" placeholder="Diagnosis" required>
  <legend>Start Date </legend>
  <label for="month_start">Month</label>
  <select id="month_start"
          name="month_start" />
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
  <select id="day_start"
          name="day_start" />
    <option value = "1">1</option>      
    <option value = "2">2</option>      
    <option value = "3">3</option>      
    <option value = "4">4</option>      
    <option value = "5">5</option>      
    <option value = "6">6</option>      
    <option value = "7">7</option>      
    <option value = "8">8</option>      
    <option value = "9">9</option>      
    <option value = "10">10</option>      
    <option value = "11">11</option>      
    <option value = "12">12</option>      
    <option value = "13">13</option>      
    <option value = "14">14</option>      
    <option value = "15">15</option>      
    <option value = "16">16</option>      
    <option value = "17">17</option>      
    <option value = "18">18</option>      
    <option value = "19">19</option>      
    <option value = "20">20</option>      
    <option value = "21">21</option>      
    <option value = "22">22</option>      
    <option value = "23">23</option>      
    <option value = "24">24</option>      
    <option value = "25">25</option>      
    <option value = "26">26</option>      
    <option value = "27">27</option>      
    <option value = "28">28</option>      
    <option value = "29">29</option>      
    <option value = "30">30</option>      
    <option value = "31">31</option>      
  </select> -
  <label for="year_start">Year</label>
  <select id="year_start"
         name="year_start" />
  <%String j = "";
    for(int i=1900;i<2026;i++)
    {
	  j = Integer.toString(i).substring(2);
	  out.println("<option value = \""+j+"\">"+i+"</option>");
    }
	  %>      
  </select>
  <span class="inst">(Month-Day-Year)</span>

  <legend>End Date </legend>
  <label for="month_end">Month</label>
  <select id="month_end"
          name="month_end" />
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
  </select> -
  <label for="day_end">Day</label>
  <select id="day_end"
          name="day_end" />
    <option value = "1">1</option>      
    <option value = "2">2</option>      
    <option value = "3">3</option>      
    <option value = "4">4</option>      
    <option value = "5">5</option>      
    <option value = "6">6</option>      
    <option value = "7">7</option>      
    <option value = "8">8</option>      
    <option value = "9">9</option>      
    <option value = "10">10</option>      
    <option value = "11">11</option>      
    <option value = "12">12</option>      
    <option value = "13">13</option>      
    <option value = "14">14</option>      
    <option value = "15">15</option>      
    <option value = "16">16</option>      
    <option value = "17">17</option>      
    <option value = "18">18</option>      
    <option value = "19">19</option>      
    <option value = "20">20</option>      
    <option value = "21">21</option>      
    <option value = "22">22</option>      
    <option value = "23">23</option>      
    <option value = "24">24</option>      
    <option value = "25">25</option>      
    <option value = "26">26</option>      
    <option value = "27">27</option>      
    <option value = "28">28</option>      
    <option value = "29">29</option>      
    <option value = "30">30</option>      
    <option value = "31">31</option>      
  </select> -
  <label for="year_end">Year</label>
  <select id="year_end"
         name="year_end" />
  <% String k = "";
  	for(int i=1900;i<2026;i++)
  	{
	   k = Integer.toString(i).substring(2);
	  out.println("<option value = \""+ j +"\">"+i+"</option>");
  	}
	  %>      
  </select>
  <span class="inst">(Month-Day-Year)</span> 
  <br/>
  <br/>
  <input type="submit" value = "SUBMIT">
	</form>
	</div>
</body>
</html>