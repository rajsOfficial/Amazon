<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dealer Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%
if(session.getAttribute("dealeremail")== null){
	%> <jsp:forward page="index.jsp"></jsp:forward>
	<%
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");
%>
<style>

.navbar-default .navbar-nav > li > a:hover,
.navbar-default .navbar-nav > li > a:focus {
    background-color: #1de9b6  ;
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
<div class="container-fluid">
<nav class="navbar navbar-default navbar-custom navbar-fixed-top">
    <div class="navbar-header">
    <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>	
      <a class="navbar-brand" href="#">Proposal</a>
    </div>
         <div id="navbarCollapse" class="collapse navbar-collapse">
    <ul class="nav navbar-nav">
	<li><a href="DealerProfile.jsp">Profile</a>
</ul>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
    </ul></div>
</nav></div>
<br><br><br><br><br>
<br><h2 align="center"> Enter Details of the Product</h2>

<br><br>


<div id="proposal" class="container">
	<form class="form-horizontal" id="formProposal">
		<div class="form-group">
			<label class="control-label col-sm-5" for="productName">ProductName:
			</label>
			<div class="col-sm-3">
				<input class="form-control" type="text" name="productName" id="productName" Placeholder="Enter Product Name" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="price">Price:
			</label>
			<div class="col-sm-3">
				<input class="form-control" type="number" name="price" id="price" Placeholder="Enter the price" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="quantity">Quantity: </label>
			<div class="col-sm-3">
				<input class="form-control" type="number" name="quantity" id="quantity" Placeholder="Enter Quantity" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="discount">Discount: </label>
			<div class="col-sm-3">
				<input class="form-control" type="number" name="discount" id="discount" Placeholder="Enter Discount" required>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-4">
				<button type="submit" id="proposalbut" class="btn btn-default">Submit</button>
			</div>
		</div>
	</form>
</div>

<script>
var ajax_Call = {
		validation : function (){
			var pName = $('#productName').val();
			var price = $('#price').val();
			var quan = $('#quantity').val();
			var disc = $('#discount').val();
			
			if(price<10000000 && quan<100000 && disc<100){
				
				var xhr = new XMLHttpRequest();
				var url = "proposal";
				xhr.open("POST", url, true);
				xhr.setRequestHeader("Content-type", "application/json");
				xhr.onreadystatechange = function() {
					 if (xhr.readyState == 4 && xhr.status == 200) {
						alert("Send to Admin for Approval");
					}
					else{
						alert('Send to Admin for Approval');
					}
				}
				var obj = {
						"productName" : pName,
						"price" : price,
						"quantity" : quan,
						"discount" : disc	};
				var data = JSON.stringify(obj);
				xhr.send(data);
	}
	else{
		alert("Please Provide Valid Details");
	}
		}
};

$(document).ready(function(){
	$("#proposalbut").click(function(){
	var dataObj  = new ajax_Call;
	ajax_Call.validate();
	});
});
</script>

</html>