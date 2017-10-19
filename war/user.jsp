<!DOCTYPE html>
<html lang="en">
<head>
<title>Dealer Profile</title>
<meta name="google-signin-client_id"
	content="430564811204-9t2gblq2m8hb51krbqh3dpvqbjl3i3hg.apps.googleusercontent.com">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<style>
.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus
	{
	background-color: #0097a7;
}

.navbar-custom {
	color: #FFFFFF;
	background-color: #263238;
}

.navbar-default .navbar-nav>li>a {
	color: white;
}

.navbar-default .navbar-header>a {
	color: white;
}

.btn-default {
	background-color:
}

div.one {
	border-bottom: 0.5px;
	border-bottom: solid;
	border-color: #C2C2BD;
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
			<a href="#" class="navbar-brand">UserPage</a>
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
<h2 align="center">Welcome To the User Login Page</h2>
<br>
<br>
<div class="container">
	<div class="col-md-6 col-md-offset-3">
		<div class="panel panel-default panel-modest">

			<div class="panel-heading">
				<div class="row">
					<div class="col-xs-offset-3 col-xs-3 ">
						<button type="button" id="login" class="btn btn-login">Login</button>
					</div>
					<div class=" col-xs-6">
						<button type="button" id="signup" class="btn btn-signup">SignUp</button>
					</div>
				</div>
			</div>

			<div id="loginform" class="panel-body">
				<h4 align="center">Login</h4>
				<form method="post" id="Loginform" class="form-horizontal"
					style="display: block" onsubmit="login()">
					<div class="form-group">
						<label class="control-label col-sm-4" for="email">Email :
						</label>
						<div class="col-sm-6">
							<input class="form-control" type="email" name="email" id="email"
								placeholder="Enter email" required>

						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-sm-4" for="pwd">Password :
						</label>
						<div class="col-sm-6">
							<input class="form-control" type="password" name="pwd" id="pwd"
								placeholder="Enter Password" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-9 col-sm-4">
							<button type="submit" id="loginbut" class="btn btn-primary">Login</button>
						</div>
					</div>
				</form>
			</div>
			<div id="signupform" class="panel-body" style="display: none">
				<h4 align="center">SignUp</h4>
				<div class="container">
					<form method="post" id="Signupform" class="form-horizontal"
						onsubmit="signUp()">
						<div class="form-group">

							<br> <label class="control-label col-sm-2" for="fname">FirstName:
							</label>
							<div class="col-sm-3">
								<input class="form-control" type="text" name="fname" id="fname"
									Placeholder="Firstname" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="lname">LastName:
							</label>
							<div class="col-sm-3">
								<input class="form-control" type="text" name="lname" id="lname"
									Placeholder="Lastname" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="number">Mobile:
							</label>
							<div class="col-sm-3">
								<input class="form-control" type="number" name="number"
									id="number" Placeholder="Mobile Number" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="emailsignup">Email:
							</label>
							<div class="col-sm-3">
								<input class="form-control" type="email" name="email"
									id="emailsignup" Placeholder="Email" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" for="pwdsignup">Password
								: </label>
							<div class="col-sm-3">
								<input class="form-control" type="password" name="pwd"
									id="pwdsignup" Placeholder="Password" required>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-4 col-sm-4">
								<button type="submit" class="btn btn-primary">SignUp</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div align="center">
	<div class="one" style="width: 40%; height: 20px; text-align: center">
		<span
			style="font-size: 20px; background-color: #F9F9F4; padding: 0 10px;">
			or </span>
	</div>
</div>
<br>
<div align="center">
	<h4>Sign in With Google</h4>
</div>
<br>
<div align="center">
	<div class="g-signin2" data-onsuccess="onSignIn"></div>
</div>
<script>

var authenticate =function(url){
	this.method = "post";
	this.Url = url;
}

authenticate.prototype.ajax = function(data){
console.log(this.Url);
	 $.ajax({
		 type:"Post",
		 url: this.Url,
			headers : {
				'Accept':'Application/json',
				'Content-Type' : 'Application/json'
			},
			data : data,
			success : function(json) {
				if (json.ans == "Good") {
					window.location.href = "UserProfile.jsp";
				} else {
					alert(json.ans);
					return false;
				}
			}
			});
}
	
	function onSignIn(googleUser){
		var id_token = googleUser.getAuthResponse().id_token;
	    var profile = googleUser.getBasicProfile();
		var obj= {"idtoken": id_token,
		  "ID" : profile.getId(),
		  "Name" : profile.getName(),
		  "ImageURL" : profile.getImageUrl(),
		  "Email" : profile.getEmail()
		};
		  var data = JSON.stringify(obj);
		  var gSignin  = new authenticate("UserGoogleLogin");
		  gSignin.ajax(data);
	}

	
	function login(){
		var obj = {
				"email" : $("#email").val(),
				"password" : $("#pwd").val()
			};
		var data = JSON.stringify(obj);
		var login = new authenticate("UserLogin");
		login.ajax(data);
	}
	
	
	function signUp (){
		
		var obj = {
			"email" : $("#emailsignup").val(),
			"pwd" : $("#pwdsignup").val(),
			"lname" : $("#lname").val(),
			"fname" : $("#fname").val(),
			"number" : $("#number").val()
		};
		var data = JSON.stringify(obj);
		var signup = new authenticate("UserSignup");
		signup.ajax(data);
	}
	
	 function signOut(){
		 var auth2 = gapi.auth2.getAuthInstance();
		  auth2.signOut().then(function () {
		    console.log('User signed out.');
		    window.location.href="logout.jsp";
		  });
	 } 
	 
$(document).ready(function() {
	$("#login").click(function() {
		document.getElementById("loginform").style.display = "block";
		document.getElementById("signupform").style.display = "none";
	});

	$("#signup").click(function() {
		document.getElementById("loginform").style.display = "none";
		document.getElementById("signupform").style.display = "block";
	});
});

</script>
</html>