<%-- <!DOCTYPE html>
<html lang="en">
<head>
  <title>Admin Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%
if(session.getAttribute("adminemail")== null){
	%> <jsp:forward page="index.jsp"></jsp:forward>
	<%
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");
%>
  <div class="container-fluid">
<nav class="navbar navbar-inverse navbar-fixed-top">

    <div class="navbar-header">
     <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
      <a class="navbar-brand" href="#">Admin Page</a>
    </div>
        <div id="navbarCollapse" class="collapse navbar-collapse">
  <ul class="nav navbar-nav navbar-right">
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="AdminProfile.jsp"><span class="glyphicon glyphicon-log-out"></span>Profile</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="todayProposal.jsp"><span class="glyphicon glyphicon-list-alt"></span>Today Proposals</a></li>
    </ul></div>
</nav>
    </div>
<br><br><br><br>
<h2 align="center">Stats<span class="glyphicon glyphicon-stats"></span> </h2><br>
<script type="text/javascript">
	
	var productValues = 0;
	 
	  $.ajax({
			url: "/statistics",
			type :"Get",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Text/Plain'
			},
			data : "",
			contentType : "Text/plain",
			success : function(response) {
           				productValues = response;
						run();
			},
		});
		
		 function run(){
	         
		            var row, table,netTotal=0;
            	    table = document.createElement('table');
            	    table.setAttribute('align','center');
            	    table.style.width= '60%';
            	    table.style.cellpadding ="19px";
            	    
            	    row = table.insertRow(0); 
            	    row.setAttribute('align','Left');
            	    row.insertCell(0).innerHTML = "Type";
            	    row.insertCell(1).innerHTML = "Description";
            	    
            	    row = table.insertRow(1); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Users Logged";
            	    row.insertCell(1).innerHTML = productValues.obj0;
            	    
             	    row = table.insertRow(2); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Products Purchased";
            	    row.insertCell(1).innerHTML = productValues.obj1;
            	    
            	    row = table.insertRow(3); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Proposals";
            	    row.insertCell(1).innerHTML = productValues.obj2;
            	    
            	    row = table.insertRow(4); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Total Amount of purchases";
            	    row.insertCell(1).innerHTML = productValues.obj3;
            	    
            	    row = table.insertRow(5); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Total Discounts";
            	    row.insertCell(1).innerHTML = productValues.obj4;
            	    
            	    row = table.insertRow(6); row.setAttribute('align','left');
            	    row.insertCell(0).innerHTML = "Net Total";
            	    row.insertCell(1).innerHTML = (productValues.obj3)-(productValues.obj4);
            	    
            	    var br =document.createElement("BR");
            	    var add= document.getElementById("addtable");
            	    add.setAttribute("align","center");
            	    add.appendChild(table);
		 }
		 </script>
		 <br>
<h4 align="center"><b>These Stats are taken for the Last 24 hours transactions</b></h4>
 <div id="addtable" align="center">
 <h3 id="show"></h3></div>

</html> --%>