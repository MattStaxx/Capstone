<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
<title>Profile</title>
</head>
<body>
	<h1 class="display-1">${user.username}'sProfile</h1>

	<nav class="p-3 bg-dark text-white">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<a href="/"
					class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
					<svg class="bi me-2" width="40" height="32">
						<use xlink:href="#bootstrap" /></svg>
				</a>

				<ul
					class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="home" class="nav-link px-2 text-secondary">Home</a></li>
					<li><a href="catalog" class="nav-link px-2 text-white">Catalog</a></li>
					<li><a href="about" class="nav-link px-2 text-white">About</a></li>
					<sec:authorize access="isAuthenticated()">
						<li><a class="nav-link px-2 text-white" href="orderhistory">Order
								History</a></li>
						<li><a class="nav-link px-2 text-white" href="shoppingcart">Cart</a></li>

					</sec:authorize>
				</ul>



				<sec:authorize access="!isAuthenticated()">
					<div class="text-end">
						<a class="btn btn-outline-light me-2" href="login">Login</a> <a
							class="btn btn-warning" href="register">Register</a>
					</div>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<div class="dropdown text-end">
						<a href="#"
							class="d-block link-dark text-decoration-none dropdown-toggle"
							id="dropdownUser1" data-bs-toggle="dropdown"
							aria-expanded="false"> <img src="https://github.com/mdo.png"
							alt="mdo" width="32" height="32" class="rounded-circle">
						</a>
						<ul class="dropdown-menu text-small"
							aria-labelledby="dropdownUser1">
							<sec:authorize access="hasAnyRole('ADMIN')">
								<li><a class="dropdown-item" href="admin">Admin</a></li>
								<li><a class="dropdown-item" href="manageinventory">Manage
										Inventory</a></li>
								<li><a class="dropdown-item" href="manageorders">Manage
										Orders</a></li>
								<li><a class="dropdown-item" href="manageusers">Manage
										Users</a></li>
							</sec:authorize>
							<li><a class="dropdown-item" href="profile">Profile</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="logout">Sign out</a></li>
						</ul>
					</div>
				</sec:authorize>
			</div>
		</div>
	</nav>
	<h6>Hi, ${user.username}</h6>
	<div class="container">
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Card Number</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><c:out value="${user.firstname}" /></td>
					<td><c:out value="${user.lastname}" /></td>
					<td><c:out value="${user.email}" /></td>
					<td><c:out value="******" /></td>
					<td><c:out value="${user.creditcard}" /></td>
				</tr>
				<br>
				<br>
			</tbody>
		</table>
		<div class="container">
			<table class="table table-striped table-bordered" id="tblData">
				<thead>

				</thead>
			</table>
		</div>
		<form action="/updateProfile" method="post">
			<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<h2>New Values</h2>
					<tr>
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
						<th scope="col">Password</th>
						<th scope="col">Card Number</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th><input type="text" name="firstname"
							placeholder="First Name" value="${user.firstname}" required></th>
						<th><input type="text" name="lastname"
							placeholder="Last Name" value="${user.lastname}"></th>
						<th><input type="text" name="email" placeholder="Email"
							value="${user.email}"></th>
						<th><input type="text" name="password" placeholder="Password"
							required></th>
						<th><input type="text" name="creditcard"
							placeholder="Card Number" value="${user.creditcard}"></th>
						<input type="hidden" name="id"
							placeholder="ID of the Product to update" required>
						<input type="hidden" name="role" placeholder="Role"
							value="${user.role}" required>
						<input type="hidden" name="username" placeholder="User Name"
							value="${user.username}" required>
						<th><input type="submit" value="Update"></th>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<footer class="page-footer font-small indigo" id="footer"
		style="width: 100%">
		<!-- Copyright -->
		<div class="footer-copyright text-center py-3">
			Copyright © 2021 Designed by <span> <a href="/about">The
					Coolest Team!</a> All rights reserved.
			</span> <a href="/profile">Back to top</a>
			<button class="btn btn-secondary" onclick="myFunction()">Dark/Light</button>
		</div>
	</footer>
	<script src="/javascript/dark.js"></script>
	<script src="/javascript/footer.js"></script>
</body>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
	crossorigin="anonymous"></script>
</html>