<!DOCTYPE html>
<html lang="en">
<head>
<title>User Profile</title>
<meta name="google-signin-client_id" content="430564811204-3vpmmbkd6j14vefia9ibsjnuvbuttbe8.apps.googleusercontent.com">
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
	<div class="container-fluid">
<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">User Page</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#" onclick="gSignOut();"><span
					class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="mycart.jsp"><span
					class="glyphicon glyphicon-user"></span> My Cart</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="UserProfile.jsp"><span
					class="glyphicon glyphicon-user"></span> Profile</a></li>
		</ul>
</nav>
	</div>
<br>
<br>
<br>
<br>
<div class="container" align="center"><h4> Thank you for Your Purchase.!</h4> </div>
<script>
var module = (function(){
function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
      window.location.href='logout.jsp';
    });
    
   }
return {
	   gsignOut : signOut
}
})(); 
function gSignOut(){
	
	module.gsignOut();
}
</script>