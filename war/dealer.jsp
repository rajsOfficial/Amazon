<!DOCTYPE html>
<html lang="en">
<head>
<title>Dealer Profile</title>
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
.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus
	{
	background-color: #1de9b6;
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
<div class="container fluid">
	<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
		<div class="navbar-header">
			<button type="button" data-target="#navbarCollapse"
				data-toggle="collapse" class="navbar-toggle">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="#" class="navbar-brand">DealerPage</a>
		</div>
		<div id="navbarCollapse" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="user.jsp"><span
						class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</ul>
		</div>
	</nav>
</div>
<br>
<br>
<br>
<br>
<br>

<h2 align="center">Welcome To the Dealer Login Page</h2>
<br>

<div id="dealerlogin" class="container">
	<form action="DealerProfile.jsp" method="post" id="loginform" class="form-horizontal"  onsubmit="return loginSub()">
		<div class="form-group">
			<label class="control-label col-sm-5" for="email">Email: </label>
			<div class="col-sm-3">
				<input class="form-control" type="email" name="email" id="email"
					placeholder="Enter email" required>
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-5" for="pwd">Password : </label>
			<div class="col-sm-3">
				<input class="form-control" type="password" name="pwd" id="pwd"
					placeholder="Enter Password" required>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-4">
				<button type="submit" id="loginbut" class="btn btn-default">Login</button>
			</div>
		</div>
	</form>
</div>
<br>
<h4 align="center">SignUp</h4>
<br>
<div id="signup" class="container">
	<form action="DealerProfile.jsp" method="post"  class="form-horizontal" onsubmit="return signupSub()">
		<div class="form-group">
			<label class="control-label col-sm-5" for="dealername">DealerName:
			</label>
			<div class="col-sm-3">
				<input class="form-control" type="text" name="dealername"
					id="dealername" Placeholder="Enter your Name" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="number">Mobile: </label>
			<div class="col-sm-3">
				<input class="form-control" type="text" name="number" id="number"
					Placeholder="Enter your Mobile Number" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="emailsignup">Email:
			</label>
			<div class="col-sm-3">
				<input class="form-control" type="email" name="email"
					id="emailsignup" Placeholder="Enter Email" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="pwdsignup">Password
				: </label>
			<div class="col-sm-3">
				<input class="form-control" type="password" name="pwd"
					id="pwdsignup" Placeholder="Enter Password" required>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-4">
				<button type="submit" class="btn btn-default">SignUp</button>
			</div>
		</div>
	</form>
</div>
<script>


var authenticate = function() {
		this.method = "post";
	};
	
authenticate.prototype={
	ajax :  function(data,Url){
		$.ajax({
			type : "post",
			url : Url,
			headers : {
				'Accept' : 'Application/json',
				'Content-Type' : 'Application/json'
			},
			data : data,
			success : function(json) {
				if (json == "Good") {
					window.location.href = "DealerProfile.jsp";
				} else {
					alert(json);
				}
			}
		});
	},
	 login : function() {
		var obj = {
			"email" : $("#email").val(),
			"password" : $("#pwd").val()
		};
		var data = JSON.stringify(obj);
		this.ajax(data,"DealerLogin");
	},
	signup : function() {
		var obj = {
			"email" : $("#emailsignup").val(),
			"pwd" : $("#pwdsignup").val(),
			"dealername" : $("#dealername").val(),
			"number" : $("#number").val()
		};
		var data = JSON.stringify(obj);
		this.ajax(data,"DealerSignup");
	}
}	

function loginSub(){
		var loginObj = new authenticate();
		loginObj.login();
		return false;
}

function signupSub() {
	var signupObj = new authenticate();
	signupObj.signup();
	return false;
}
</script>

</html>