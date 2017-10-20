<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dealer Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%
if(session.getAttribute("dealeremail")== null){
	%> <jsp:forward page="index.jsp"></jsp:forward>
	<%
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");
%>
<style>

.navbar-default .navbar-nav > li > a:hover,
.navbar-default .navbar-nav > li > a:focus {
    background-color: #1de9b6  ;
}
.navbar-custom {
    color: #FFFFFF;
    background-color: #4C3C3C;
}
.navbar-default .navbar-nav>li>a
	{
	color: white;
}
.navbar-default .navbar-header>a
	{
	color: white;
}
</style>
  <div class="container-fluid">
<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
    <div class="navbar-header">
			<button type="button" data-target="#navbarCollapse"
				data-toggle="collapse" class="navbar-toggle">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="#" class="navbar-brand">UserPage</a>
		</div>
		<div id="navbarCollapse" class="collapse navbar-collapse">
  <ul class="nav navbar-nav navbar-right">
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span> LogOut</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="Proposal.jsp"><span class="glyphicon glyphicon-user"></span> Make Proposal</a></li>
    </ul>
    </div>
</nav></div>
<br><br><br><br>

<h2 align="center">Welcome</h2><br>

<h3 align="center">Products Delivered By You</h3>
<script type="text/javascript">
var authenticate = function(url){
	this.Url = url ;
}

authenticate.prototype = {
	
	calling : function(){
	$.ajax({
			url: this.Url,
			type :"POST",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Text/Plain'
			},
			data : "",
			contentType : "Text/plain",
			success : function(response) {
				authenticate.prototype.run(response);
			},
			error : function() {
				  alert('Error while request..');
				}
	  });
},


 run : function(result){
	 $.each(result, function (index, value) {
    	 var cell, row, table;
    	    table = document.createElement('table');
    	    table.setAttribute('align','center');
    	    table.style.width= '60%';
    	    
    	    table.setAttribute("class","table table-bordered");
    	    row = table.insertRow(0); 
    	    row.setAttribute('align','center');
    	    var x= row.insertCell(0);x.innerHTML = "Type";
    	    x.style.color="white";
    	    x.style.width="50%";
    	   	var y= row.insertCell(1);
    	   	y.innerHTML = "Description";
    	    y.style.color="white";
    	    row.style.backgroundColor ="#9e9e9e ";
    	    
    	    row = table.insertRow(1); row.setAttribute('align','center');
    	    row.insertCell(0).innerHTML = "ProductName";
    	    row.insertCell(1).innerHTML = value.productname;
    	    
    	    row = table.insertRow(2); row.setAttribute('align','center');
    	    row.insertCell(0).innerHTML = "Price";
    	    row.insertCell(1).innerHTML = value.price;
    	    
    	    row = table.insertRow(3); row.setAttribute('align','center');
    	    row.insertCell(0).innerHTML = "Quantity";
    	    row.insertCell(1).innerHTML = value.quantity;
    	    
    	    row = table.insertRow(4); row.setAttribute('align','center');
    	    row.insertCell(0).innerHTML = "Discount";
    	    row.insertCell(1).innerHTML = value.discount;
    	    document.createElement("BR");
    	    document.createElement("BR");
    	    document.getElementById("addtable").appendChild(table);
});
}
}
var ajax = new authenticate("DealerProfile");
ajax.calling();
</script>
					<div id="addtable" align="center">
 <h3 id="show"></h3></div>
				</html>
