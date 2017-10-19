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
</style>	<div class="container-fluid">

<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
		<div class="navbar-header">
		 <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
			<a class="navbar-brand" href="#">User Page</a>
		</div>
		 <div id="navbarCollapse" class="collapse navbar-collapse">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#" onclick="signOut();"><span
					class="glyphicon glyphicon-log-out"></span> LogOut</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="mycart.jsp"><span
					class="glyphicon glyphicon-shopping-cart"></span> My Cart</a></li>
		</ul>
			<ul class="nav navbar-nav navbar-right">
			<li><a href="UserProfile.jsp"><span
					class="glyphicon glyphicon-user"></span>Profile</a></li>
		</ul></div>
</nav>	</div>
<br>			
<br>
<br>
<br>
<h2 align="center">Payment Page</h2><br>
<h3 align="center">	Choose Your Payment Option</h3><br>
<div class="container-fluid" align="center">
<form>
  <input type="radio" id="cashPayment" name="deliveryOption" value="Cash On Delivery" checked > Cash On Delivery<br>
  <input type="radio" id="cardPayment" name="deliveryOption" value="Card payment"> Card Payment <br>
</form> 
</div><br><br>
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

 $(document).ready(function(){
	 
	$("#cardPayment").click(function(){
		document.getElementById("card").style.display="block";
		document.getElementById("cash").style.display="none";
	});
	$("#cashPayment").click(function(){
		document.getElementById("card").style.display="none";
		document.getElementById("cash").style.display="block";
	});
 });

 function signOut(){
	 module.gsignOut();
 }
/* 
	 function logout(){
		 var auth2 = gapi.auth2.getAuthInstance();
		  auth2.signOut().then(function () {
		    console.log('User signed out.');
		    window.location.href="logout.jsp";
		  });
	 } */
</script><div align="center" style="display:none"><div class="g-signin2" data-onsuccess="onSignIn"></div></div>

<div id="card" style= "display:none;" class="container">
	
	<form id="formcard" action="output" method="post" class="form-horizontal">
		<div class="form-group">
			<label class="control-label col-sm-5" for="bank">Choose your Bank:
			</label>
			<div class="col-sm-3">
				<select id="bankSelect">
					<option value="ICICI">ICICI Bank </option>
					<option value="StateBankOfIndia">State Bank Of India</option>
					<option value="AxisBank">Axis Bank</option>
					<option value="HdfcBank">HDFC Bank</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="accnumber">Account Number: </label>
			<div class="col-sm-3">
				<input class="form-control" type="number" name="accnumber" id="accnumber" Placeholder="Enter Account Number" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="cvv">Cvv :
			</label>
			<div class="col-sm-3">
				<input class="form-control" type="password" name="cvv" id="cvv" Placeholder="Enter cvv" maxlength="3" required>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-4">
				<button type="submit" id="finishcard"  class="btn btn-primary">Finish</button>
			</div>
		</div>
	</form>

</div>


<div id="cash" class="container" align="center">
<form action="Finish.jsp" class="container-fluid">
	<div class="form-group">
			<div class="col-sm-offset-4 col-sm-4">
				<button type="submit"  id="finishcash" class="btn btn-primary">Finish</button>
			</div>
		</div>
		</form>
</div>


</html>