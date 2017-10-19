<!DOCTYPE html>
<html lang="en">
<head>
  <title>Admin Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
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
    </ul></div>
</nav>
    </div>
<br><br><br><br>

<h2 align="center">Today's Proposals</h2>
<script type="text/javascript">
var module = (function(){
	var productValues = 0;
	function ajax(){ 
	  $.ajax({
			url: "/todayProposal",
			type :"Get",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Text/Plain'
			},
			data : "",
			contentType : "Text/plain",
			success : function(response) {
						if(response=="empty"){
							var h3 = document.createElement('h3');
							var t1 =document.createTextNode("Nothing to display");
							h3.appendChild(t1);
							var show = document.getElementById("addtable");
							show.appendChild(h3);
						}
						else{
           				productValues = response;
						run();
						}
			},
			error : function() {
				var h3 = document.createElement('h3');
				var t1 =document.createTextNode("Nothing to display");
				h3.appendChild(t1);
				var show = document.getElementById("addtable");
				show.appendChild(h3);
			}
		});
	}
		 function run(){
	         $.each(productValues, function (index, value) {
	         
		            var row, table;
            	    table = document.createElement('table');
            	    table.setAttribute('align','center');
            	    table.style.width= '60%';
            	    table.style.cellpadding ="15px";
            	    
            	    table.setAttribute("class","table table-bordered");
            	    row = table.insertRow(0); 
            	    row.setAttribute('align','center');
            	    row.insertCell(0).innerHTML = "Type";
            	    row.insertCell(1).innerHTML = "Description";
            	    
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
            	    var br =document.createElement("BR");
            	    var add= document.getElementById("addtable");
            	    add.setAttribute("align","center");
            	    add.appendChild(table);

	  	  });
		 }	 
		 return {
			 ajax_call : ajax
		 } 
})();
	
	module.ajax();

		 </script>
		 <br>
 <div id="addtable" align="center">
 <h3 id="show"></h3></div>
</html>