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
<script type="text/javascript">
	var module = (function(){
		
	var productValues = 0;
	
	function profile_call(){
	  $.ajax({
			url: "/UserProfile",
			type :"POST",
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Text/Plain'
			},
			data : "",
			contentType : "Text/plain",
			success : function(response) {
				if(response){
   				productValues = response;
				run();
				}	
				else {
					document.getElementById("show").innerHTML="Nothing to display";
				}
			},
			error : function() {
			  alert('Error while request..');
			}
		});
	}
		 function run(){
			 
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
            	   	btn.addEventListener("click",function(){validation(value.id);});
            	   	
            	   	add.appendChild(btn);
            	   	var div =document.createElement("div");
            	   	var linebreak= document.createElement("br");
            	   	div.appendChild(linebreak);
					add.appendChild(div);
	  	  });
		 }
		 
		function validation(number){
			 var obj={"identity": number };
			 $.ajax({
				 type:"Get",
				 url: "cartAdd",
					headers : {
						'Accept':'Text/Plain',
						'Content-Type' : 'Application/json'
					},
					data : "jsonObj="+JSON.stringify(obj),
					success : function(response) {
						alert("Added to Cart ");
					},
					error : function() {
					  alert('Error while request..');
					}

			 });
		 }
		
		/* 
		$("#aboutButton").click(function about(){
			 var obj={"identity": number };
			 $.ajax({
				 type:"Get",
				 url: "/about",
					headers : {
						'Accept':'Text/Plain',
						'Content-Type' : 'Application/json'
					},
					data : "",
					contentType : "Text/plain",
					success : function(response) {
						  var row, table;
		            	    table = document.createElement('table');
		            	    table.setAttribute('align','center');
		            	    table.style.width= '30%';
		            	    table.style.cellpadding ="12px";
		            	    
		            	    row = table.insertRow(1); row.setAttribute('align','center');
		            	    row.insertCell(0).innerHTML = "FirstName";
		            	    row.insertCell(1).innerHTML = response.obj.firstname;
		            	    
		            	    row = table.insertRow(2); row.setAttribute('align','center');
		            	    row.insertCell(0).innerHTML = "LastName";
		            	    row.insertCell(1).innerHTML = response.obj.lastname;
		            	    
		            	    row = table.insertRow(3); row.setAttribute('align','center');
		            	    row.insertCell(0).innerHTML = "Mobile";
		            	    row.insertCell(1).innerHTML = response.obj.number;
		            	    var add= document.getElementById("about");
		            	    add.setAttribute("align","center");
		            	    add.appendChild(table);
						
					},
					error : function() {
					  alert('Error while request..');
					}

			 });
		 }); */
		    function signOut() {
		      var auth2 = gapi.auth2.getAuthInstance();
		      auth2.signOut().then(function () {
		        console.log('User signed out.');
		        window.location.href='logout.jsp';
		      });
		    }
	
		 return {
		 	profile_ajax : profile_call,
		 	signout : signOut
		 }; 
	}) ();

	module.profile_ajax();
	function gSignOut(){
	module.signout();
	}
</script>
			<div id="addtable" align="center">
 <h3 id="show"></h3></div>
 </div>
 
				</html>
