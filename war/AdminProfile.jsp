<!DOCTYPE html>
<html lang="en">
<head>
  <title>User Profile</title>
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
    <ul class="nav navbar-nav">
	<li><a href="#">Home</a>
</ul>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="todayProposal.jsp"><span class="glyphicon glyphicon-list-alt"></span> Today Proposal</a></li>
    </ul>
    </div>
</nav>
    </div>
<br><br><br><br>

<h2 align="center">Welcome</h2>
<br>
			<div class="col-sm-offset-9 col-sm-4">
				<button type="submit" id="rejectAll" class="btn btn-warning btn-sm">RejectAll</button>
			</div><br>
			<div id="addtable" align="center">
 <h3 id="show"></h3></div>
<script type="text/javascript">
	
	var productValues = 0;
var adminObj = function(url){
	this.Url = url;
}

adminObj.prototype.ajax = function(obj){
	console.log(obj);
	  $.ajax({
			url: this.Url,
			type :"get",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Application/json'
			},
			data : "jsonObj="+JSON.stringify(obj),
			success : function(response) {
           				productValues = response;
						run();
			},
			error : function() {
			  alert('Error while request..');
			}
		});
	 }
	 
	 var data = new adminObj("AdminProfile");
	 data.ajax("");
	 
	 
		 function run(){	
			 if(typeof productValues.obj1 === "undefined"){
				var h3 = document.createElement('h3');
				var t1 =document.createTextNode("Nothing to display");
				h3.appendChild(t1);
				h3.setAttribute("align","center");
				document.getElementById("addtable").appendChild(h3);
			}
			else{
	         $.each(productValues, function (index, value) {
	         
		            var row, table;
            	    table = document.createElement('table');
            	    table.setAttribute('align','center');
            	    table.style.width= '55%';
            	    table.setAttribute("class","table table-bordered");
            	    row = table.insertRow(0); 
            	    row.setAttribute('align','center');
            	   	var head= row.insertCell(0);
            	   	head.innerHTML = "Type";
            	   	head.style.width='50%';
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
            	  	var acceptBtn = document.createElement("Button");
            	   	acceptBtn.setAttribute("class","btn btn-primary");
            	   	acceptBtn.innerHTML="Accept";
            	   	acceptBtn.setAttribute("id","acceptId");
            	   	acceptBtn.setAttribute("value",value.id);
         	 	   	acceptBtn.addEventListener("click",function(){accept(value.id);});
         	 	   	
            	   	add.appendChild(acceptBtn);
            		var rejectBtn = document.createElement("Button");
            	   	rejectBtn.setAttribute("class","btn btn-primary");
            	   	rejectBtn.innerHTML="Reject";
            	   	rejectBtn.setAttribute("id","rejectId");
            	   	rejectBtn.setAttribute("value",value.id);
         	 	   	rejectBtn.addEventListener("click",function(){reject(value.id);});
         	 	   	
            	   	add.appendChild(rejectBtn);
            	   	var div =document.createElement("div");
            	   	var linebreak= document.createElement("br");
            	   	div.appendChild(linebreak);
					add.appendChild(div);

	  	  });
		 }
		 }
		 
		 function accept(number){
			 var obj={"identity": number };
			 var acpt = new adminObj("datastoreAdd"); 
			 acpt.ajax(obj);
			 alert("successfully added");
			 window.location.href="AdminProfile.jsp";
		 }
		 
		 function reject(number){
			 var obj={"identity": number };
			 var rjct = new adminObj("deleteProposal"); 
			 rjct.ajax(obj);
			 alert("Removed successfully ");
			 window.location.href="AdminProfile.jsp";
		 }
		 
		function rejectAll(){
		var rjctAll = new adminObj("taskReject");
		rjctAll.ajax("");
		alert("success");
		window.location.href="AdminProfile.jsp";
		}
	
	$(document).ready(function(){
	$("#rejectAll").click(function(){
	rejectall();
	});  });
	
</script><br>
 
</html>
