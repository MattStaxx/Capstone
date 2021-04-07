<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
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
	<div class="user-form">
		<h1>Register Form</h1>
		<form action="/register" method="POST">
			<div style="color: #FF0000;">${errorMessage}</div>
			<input type="text" name="firstname" placeholder="First Name" required>
			<input type="text" name="lastname" placeholder="Last Name" required>
			<input type="text" name="username" placeholder="Username" required>
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" name="password" placeholder="Password"
				required> <input type="submit" value="Register">
		</form>
		<hr>
		<form action="/login" method="GET">
			<input type="submit" value="Go back to Login Page">
		</form>
	</div class=>


</body>
</html>