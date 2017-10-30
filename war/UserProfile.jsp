<!DOCTYPE html>
<html lang="en">
<head>
  <title>User Profile</title>
  <meta name="google-signin-client_id" content="430564811204-9t2gblq2m8hb51krbqh3dpvqbjl3i3hg.apps.googleusercontent.com">
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
String pictureUrl;
if(session.getAttribute("pictureUrl")!=null){
	 pictureUrl= (String)session.getAttribute("pictureUrl");
}
else{
	pictureUrl= null;
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
	background-color: #263238 ;
}
.navbar-default .navbar-nav>li>a
	{
	color: white;
}
.navbar-default .navbar-header>a
	{
	color: white;
}


.nav>li>a>img {
    max-width: 32px;
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
        <a href="#" class="navbar-brand">Welcome</a>
    </div>
    <div id="navbarCollapse" class="collapse navbar-collapse">
    <ul class="nav navbar-nav">
	<li><a href="#">Profile</a></li>
</ul>
 <ul class="nav navbar-nav ">
 	<li> <a class="navbar-brand" href="#">
  <img class="pic"  style="margin : 0; float: none;" >
</a></li>
 </ul>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="#" onclick="gSignOut();"><span class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
    </ul>
   
    <ul class="nav navbar-nav navbar-right">
      <li><a href="mycart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> My Cart</a></li>
    </ul>
    </div>
</nav>
</div>
<br><br><br><br>
<div class="col-lg-9 col-sm-12 right">
<h2 align="center">Welcome</h2><br>
<div id="addtable" align="center">
 <h3 id="show"></h3></div>
 </div>
<script type="text/javascript">
var productValues = 0;
var authenticate = function(url){
	this.Url = url ;
}

authenticate.prototype = {
	
	ajax : function(data,Url){
	  $.ajax({
			url: Url,
			type :"POST",
			headers : {
				'Accept':'Application/json',
				'Content-Type' :'Application/json'
			},
			data : data,
			success : function(response) {
   				productValues = response;
				authenticate.prototype.run();
				},
			error : function() {
			  alert('Error while request..');
			}
		});
	},
	
	run : function(){
			  if(typeof productValues.obj0 === "undefined"){
					var h3 = document.createElement('h3');
					var t1 =document.createTextNode("Nothing to display");
					h3.appendChild(t1);
					h3.setAttribute("align","center");
					document.getElementById("addtable").appendChild(h3);
				}
			  else {
	         $.each(productValues, function (index, value) {
		            var row, table;
            	    table = document.createElement('table');
            	    table.setAttribute('align','center');
            	    table.style.width= '60%';
            	    table.style.cellpadding ="7px";
            	    
            	    table.setAttribute("class","table table-bordered");
            	    row = table.insertRow(0); 
            	    row.setAttribute('align','center');
            	    var x= row.insertCell(0);x.innerHTML = "Type";
            	    x.style.color="white";
            	    x.style.width="50%";
            	   	var y= row.insertCell(1);
            	   	y.innerHTML = "Description";
            	    y.style.color="white";
            	    row.style.backgroundColor ="#006064";
            	    
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
            	    var add= document.getElementById("addtable");
            	    add.setAttribute("align","center");
            	    add.appendChild(table);
            	  	var btn = document.createElement("Button");
            	   	btn.setAttribute("class","btn btn-primary");
            	   	btn.innerHTML="Add to Cart";
            	   	btn.setAttribute("value",value.id);
            	   	btn.setAttribute("id","btn");
            	   	btn.addEventListener("click",function(){authenticate.prototype.cartAdd(value.id);});
            	   	
            	   	add.appendChild(btn);
            	   	var div =document.createElement("div");
            	   	var linebreak= document.createElement("br");
            	   	div.appendChild(linebreak);
					add.appendChild(div);
	  	  });
	         }
		 },
		 
	cartAdd : function(number){
			 var obj={"identity": number };
			 var data =JSON.stringify(obj);
			 authenticate.prototype.ajax(data,"cartAdd");			 
			 alert("Added to Cart ");
		 },
		
	signOut : function() {
		      var auth2 = gapi.auth2.getAuthInstance();
		      auth2.signOut().then(function () {
		        console.log('User signed out.');
		        window.location.href='logout.jsp';
		      });
		    }
}

	
	function gSignOut(){
	var signoutObj = new authenticate();
	signoutObj.signOut();
	}
	
	var userObj = new authenticate();
	userObj.ajax("","UserProfile");
</script>
</html>
