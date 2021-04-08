<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
    	  rel="stylesheet" 
    	  integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
    	  crossorigin="anonymous">
  	<link rel="stylesheet" href="css/style.css">
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<h1 class="display-1">The Music Store</h1>
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark justify-content-center">
		<div class="container-fluid">
			<a class="navbar-brand" href="home">Home</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
				aria-controls="navbarNavAltMarkup" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav"">
					<a class="nav-link" href="catalog">Catalog</a> <a class="nav-link"
						href="about">About</a>
					<sec:authorize access="isAuthenticated()">
						<a class="nav-link" href="shoppingcart">Cart</a>
						<a class="nav-link" href="orderhistory">Order History</a>
						<a class="nav-link" href="profile">Profile</a>
					</sec:authorize>
					
					<sec:authorize access="hasAnyRole('ADMIN')">

						<a class="nav-link" href="admin">Admin</a>
						<a class="nav-link" href="manageinventory">Manage Inventory</a>
						<a class="nav-link" href="manageusers">Manage Orders</a>
						<a class="nav-link" href="manageusers">Manage Users</a>
					</sec:authorize>

					<sec:authorize access="!isAuthenticated()">

						<a class="nav-link" href="login">Login</a>
						<a class="nav-link" href="register">Register</a>

					</sec:authorize>

					<sec:authorize access="isAuthenticated()">
						<a class="nav-link" href="logout">Logout</a>
					</sec:authorize>
				</div>
			</div>
		</div>
	</nav>
	<div class="user-form" id="submit2">
		<h1>Register Form</h1>
		<form action="/register" method="POST">
			<div style="color: #FF0000;">${errorMessage}</div>
			<input type="text" name="firstname" placeholder="First Name" required>
			<input type="text" name="lastname" placeholder="Last Name" required>
			<input type="text" name="username" placeholder="Username" required>
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" name="password" placeholder="Password" id="password" required > 
			<input type="password" name="password2" placeholder="Confirm password" id="password2" required> 
			<input type="submit" value="Register" id="submit" >
		</form>
		<hr>
		
	</div>
	<form class="user-form" action="/login" method="GET">
		<input type="submit" value="Go Back To Login" id="submit" >
	</form>
	<script>
	var password = document.getElementById("password");
	var confirm_password = document.getElementById("password2");
	var x = document.getElementById("submit2");
	x.setAttribute('onsubmit','event.preventDefault();');
	
	function validatePassword(){
	  if(password.value != confirm_password.value) {
		  console.log("passwords don't match");
		  x.setAttribute('onsubmit','event.preventDefault();');
	    confirm_password.setCustomValidity("Passwords Don't Match");
	  } else {
		  x.setAttribute('onsubmit','console.log(\'hello\');');
		  console.log("passwords match");
	    confirm_password.setCustomValidity('');
	  }
	}
	
	password.onkeyup = function(){ validatePassword();};
	confirm_password.onkeyup =  function(){validatePassword()};

	</script>


</body>
</html>
