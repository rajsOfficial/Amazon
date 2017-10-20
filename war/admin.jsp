<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Login</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>

.navbar-default .navbar-nav > li > a:hover,
.navbar-default .navbar-nav > li > a:focus {
    background-color: #1de9b6  ;
}

</style>
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Admin LogIn</a>
    </div>
    <ul class="nav navbar-nav">
	<li><a href="index.jsp">Home</a>
</ul>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="admin.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul></div>
</nav>
<br><br><br><br>

<h2 align="center">Welcome To the Admin Login Page</h2>
<br>
<br><br>
<div class="container">
	<form id="signIn" class="form-horizontal" action="AdminProfile.jsp" method="Post">
		<div class="form-group">
			<label class="control-label col-sm-5" for="email">Email: </label>
			<div class="col-sm-3">
				<input type="email" class="form-control" name="email" id="email"
					placeholder="Enter email" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="pwd">Password : </label>
			<div class="col-sm-3">
				<input type="password" class="form-control" name="pwd" id="pwd"
					placeholder="Enter Password" required>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-4">
				<button type="submit" class="btn btn-default">Login</button>
			</div>
		</div>
	</form>
</div>

<br>
<h5>Email is : admin@full.co</h5>
<h5>Password is : admin</h5>


<script>
var authenticate = function (){
};

authenticate.prototype = {
		validate : function(){
			var Email = $("#email").val();
			var Pwd = $("#pwd").val();
			if (Email == "admin@full.co" && Pwd == "admin") {
				return true;
			} else {
				alert("Please Enter Valid Details");
				return false;
			}
		}
};

$(document).ready(function(){
		$('#signIn').submit(function() {
			var signInObj = new authenticate();
			return authenticate.validate();
		});
	});
	
</script>


</html>
