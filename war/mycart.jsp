<!DOCTYPE html>
<html lang="en">
<head>
<title>User Cart</title>
 <meta name="google-signin-client_id" content="430564811204-3vpmmbkd6j14vefia9ibsjnuvbuttbe8.apps.googleusercontent.com">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
</head>
<%
if(session.getAttribute("useremail")== null){
	%> <jsp:forward page="index.jsp"></jsp:forward>
	<%
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");

%>
<style>
.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus
	{
	background-color: #0097a7;
}

.navbar-custom {
	color: #FFFFFF;
	background-color: #263238;
}
.navbar-default .navbar-nav>li>a
	{
	color: white;
}
.navbar-default .navbar-header>a
	{
	color: white;
}
</style><div align="center" style="display:none"><div class="g-signin2" data-onsuccess="onSignIn"></div></div>
<div class="container fluid">
<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
    <div class="navbar-header">
       <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="#" class="navbar-brand">UserPage</a>
    </div>
    <div id="navbarCollapse" class="collapse navbar-collapse">
   <div class="navbar-header">
			<a class="navbar-brand" href="#">My Cart</a>
		</div>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="#" onclick="gSignOut();"><span class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
    </ul>
    	<ul class="nav navbar-nav navbar-right">
			<li><a href="UserProfile.jsp"><span
					class="glyphicon glyphicon-user"></span> Profile</a></li>
		</ul>
    </div>
</nav>
</div>

<br>
<br>
<br>
<br>

<h2 align="center">Welcome</h2>
<br>
<h3 align="center">Items in Your Cart</h3><br>
<div id="addtable"></div>
<div id="button1"></div>
<script type="text/javascript">
var productValues = 0;

var cart = function(){ 
	this.method = "get";
}
cart.prototype ={
	ajax : function(obj,Url){
		console.log("into ajax call");
		
		$.ajax({
			url: Url,
			type :"Get",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Application/json'
			},
			data :  "jsonObj="+JSON.stringify(obj),
			success : function(response) {
				productValues= response;
				console.log(productValues);
				cart.prototype.run();
			},
			error : function() {
			  alert('Error while request..');
			}
		});
	},
	remove : function(number){
		console.log("into the remove");
		 var obj={"identity": number };
		 this.ajax(obj,"Cartremove");
		 alert("Removed Successfully");
		 window.location.href="mycart.jsp";
	},

	delivery : function(number){
		console.log("into delivery method");
		 var obj={"identity": number };
		 this.ajax(obj,"delivery");
		 window.location.href="delivery.jsp";
	},

	run : function(){
		console.log("into run");
				var count=1;
				if(typeof productValues.obj1 === "undefined"){
					var h3 = document.createElement('h3');
					var t1 =document.createTextNode("Nothing to display");
					h3.appendChild(t1);
					h3.setAttribute("align","center");
					document.getElementById("addtable").appendChild(h3);
				}
				else{
		         $.each(productValues, function (index, value) {
			            var cell, row, table;
	            	    table = document.createElement('table');
	            	    table.setAttribute('align','center');
	            	    table.style.width= '60%';
	            	    table.style.cellpadding ="19px";
	            	    
	            	    table.setAttribute("class","table table-bordered");
	            	    row = table.insertRow(0); 
	            	    row.setAttribute('align','center');
	            	    var x= row.insertCell(0);x.innerHTML = "Type";
	            	    x.style.color="white";
	            	   	var y= row.insertCell(1);
	            	   	y.innerHTML = "Description";
	            	    y.style.color="white";
	            	    row.style.backgroundColor ="#006064";
	            	    row = table.insertRow(1); row.setAttribute('align','center');
	            	    var prod=  row.insertCell(0); prod.innerHTML = "ProductName";
	            	    prod.setAttribute("value",value.id);
	            	    prod.setAttribute("id","nn");
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
	            	    var br =document.createElement("br");
	            	    var add= document.getElementById("addtable");
	            	    add.setAttribute("align","center");
	            	    add.appendChild(br);
	            	 	add.appendChild(br);
	            	    add.appendChild(table);
	            	  	var buyBtn = document.createElement("Button");
	            	   	buyBtn.setAttribute("class","btn btn-primary");
	            	   	buyBtn.innerHTML="Buy";
	            	   	buyBtn.setAttribute("value",count);
	            	   	buyBtn.setAttribute("id","deliveryBtn");
	         	 	   	buyBtn.addEventListener("click",function(){ cart.prototype.delivery(value.id);});
	            	   	add.appendChild(buyBtn);
	            	   	
	            	   	var removeBtn = document.createElement("Button");
	            	   	removeBtn.setAttribute("class","btn btn-primary");
	            	   	removeBtn.innerHTML="remove";
	            	   	removeBtn.setAttribute("id","removeBtn");
	            	   	removeBtn.setAttribute("value",count);
	         	 	   	removeBtn.addEventListener("click",function(){cart.prototype.remove(value.id);});
	            	   	add.appendChild(removeBtn);
	            	   	var div =document.createElement("div");
	            	   	var linebreak= document.createElement("br");
	            	   	div.appendChild(linebreak);
						add.appendChild(div);
						count++;
		  	  });
			 }
			 }
	}
	function call(){
		console.log("into call function");
		 var cartDetails = new cart();
		 cartDetails.ajax("","myCart");
}
		
		 function gSignOut() {
		      var auth2 = gapi.auth2.getAuthInstance();
		      auth2.signOut().then(function () {
		        console.log('User signed out.');
		        window.location.href='logout.jsp';
		      });
		    }
		 call();
</script>

</html>
