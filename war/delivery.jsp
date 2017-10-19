<!DOCTYPE html>
<html lang="en">
<head>
<title>User Profile</title>
  <meta name="google-signin-client_id" content="430564811204-9t2gblq2m8hb51krbqh3dpvqbjl3i3hg.apps.googleusercontent.com">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
td, th {
	padding: 15px 75px;
	text-align: left;
}

.table {
	width: 60%;
	align: center;
}

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
    <ul class="nav navbar-nav">
	<li><a href="index.jsp">Home</a>
</ul>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="#" onclick="signOut();"><span class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="mycart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> My Cart</a></li>
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

<h2 align="center">Please Provide Product Delivery Details</h2>
<br>
<div id="addtable"></div>
<script>

var productValues = 0;


var details = function(url){
 	this.method = "post";
 	this.Url = url;
 }
details.prototype.ajax= function(data){
	 $.ajax({
			url: this.Url,
			type :this.method,
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Text/Plain'
			},
			data : data,
			contentType : "Text/plain",
			success : function(response) {
					productValues =response;
	       			run();
			},
			error : function() {
			  alert('Error while request..');
			}
		});
}

function deliveryOut(){
		var mobileNum = $('#phNumber').val();
		var addr = $('#address').val();
		if(mobileNum >= 1000000000 && mobileNum>999999999){
		var quan = $('#mySelect').val();
		var total= quan * productValues.price;
		alert("Total amount is "+total);
		var obj ={ "quan":quan,"identity":productValues.id,"disc":productValues.discount,"total":total,"mobileNum":mobileNum,"addr":addr};
		var data=JSON.stringify(obj);
		 
		var delivery  = new details("buyProduct");
		delivery.ajax(data);
			window.location.href="Output.jsp";
		}
		else {
			alert("Enter a Valid Mobile Number");
		}
	 }
	 
function signOut() {
	      var auth2 = gapi.auth2.getAuthInstance();
	      auth2.signOut().then(function () {
	        console.log('User signed out.');
	        window.location.href="logout.jsp";
	      });
	    }
	    
	    
var deliveryDetails = new details("deliveryPage");
deliveryDetails.ajax("");


function run(){
    var cell, row, table;
    table = document.createElement('table');
    table.setAttribute('align','center');
    table.style.width= '60%';
    table.style.cellpadding ="19px";
    row = table.insertRow(0); 
    row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Type";
    row.insertCell(1).innerHTML = "Description";
    
    row = table.insertRow(1); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "ProductName";
    row.insertCell(1).innerHTML = productValues.productname;
    
    row = table.insertRow(2); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Price";
    row.insertCell(1).innerHTML = productValues.price;
    
    row = table.insertRow(3); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Quantity";
  
    var x = document.createElement("SELECT");
    x.setAttribute("id", "mySelect");
    for(n=1; n<=productValues.quantity;n++){
    var z = document.createElement("option");
    z.setAttribute("value", n);
    var t = document.createTextNode(n);
    z.appendChild(t);
    x.appendChild(z);

    }
    row.insertCell(1).appendChild(x);
    
    row = table.insertRow(4); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Discount";
    row.insertCell(1).innerHTML = productValues.discount+"%";
    
    row = table.insertRow(5); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Mobile";
    var input = document.createElement("input");
    input.setAttribute("type","number");
    input.setAttribute("id","phNumber");
    input.required=true;
    row.insertCell(1).appendChild(input);
    
   	row = table.insertRow(6); row.setAttribute('align','center');
    row.insertCell(0).innerHTML = "Address";
    var addrBox =  document.createElement("textarea");
    addrBox.setAttribute("id","address");
    addrBox.setAttribute("required","");
    row.insertCell(1).appendChild(addrBox);
    
    var br =document.createElement("BR");
    var add= document.getElementById("addtable");
    add.setAttribute("align","center");
    add.appendChild(table);
  	var btn = document.createElement("Button");
   	btn.setAttribute("class","btn btn-primary");
   	btn.innerHTML="Buy";
	   	btn.onclick= function(){deliveryOut();};
	   	
   	add.appendChild(btn);
 	add.appendChild(br);
 	add.appendChild(br);
    
}

</script>
</body>
</html>