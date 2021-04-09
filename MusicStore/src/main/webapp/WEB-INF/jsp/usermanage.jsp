<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hcl.MusicStore.entities.MusicUser"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">

<title>Manage Users</title>
</head>
<body>
	<h1 class="display-1">Managing Users</h1>
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

	<div class="container">
		<div class="col-11">

			<div id="emptyFieldErrorMessage"
				style="display: none; text-align: center;">
				<br /> <b style="color: red; text-align: center">Error: Missing
					required information!</b> <br />
			</div>

			<div id="deleteErrorMessage"
				style="visibility: hidden; text-align: center;">
				<br /> <b style="color: red; text-align: center">Error: Cannot
					delete logged in User!</b> <br />
			</div>

			<div id="deleteSuccessMessage"
				style="visibility: hidden; text-align: center;">
				<br /> <b style="color: red; text-align: center">User
					Successfully Deleted!</b> <br />
			</div>
		</div>
		<button type="button" id="btnAdd" class="btn btn-default btn-sm"></button>

		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr>
					<h1>List of All Users</h1>
				</tr>
				<tr>
					<th scope="col">Id</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Username</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Role</th>
					<th></th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${users}" var="user">
					<tr>
						<td><c:out value="${user.id}" /></td>
						<td><c:out value="${user.firstname}" /></td>
						<td><c:out value="${user.lastname}" /></td>
						<td><c:out value="${user.username}" /></td>
						<td><c:out value="${user.email}" /></td>
						<td><c:out value="******" /></td>
						<td><c:out value="${user.role}" /></td>
						<td>
							<form action="/deleteUser" method="post"">
								<input type="hidden" name="id" value="${user.id}"> <input
									type="submit" value="Delete">
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div style="color: #0000FF;">${successMessage}</div>
		<div style="color: #FF0000;">${errorMessage}</div>

		<div class="col-11">
			<form action="/addUser" method="post">
				<table class="table table-striped table-bordered" id="tblData">
					<thead>
						<tr>
							<h1>Add a User</h1>
						</tr>
						<tr>
							<th><select name="role" id="role">
									<option value="" disabled selected>Account Type</option>
									<option value="USER">User</option>
									<option value="ADMIN">Admin</option>
							</select>
							<th><input type="submit" value="Add"></th>
					</thead>
					<tbody>
						<tr>
							<th><input type="text" name="firstname" id="firstname"
								placeholder="First Name" required></th>
							<th><input type="text" name="lastname" id="lastname"
								placeholder="Last Name" required></th>
							<th><input type="text" name="username" id="username"
								placeholder="Username" required></th>
							<th><input type="email" name="email" id="email"
								placeholder="Email" required></th>
							<th><input type="password" name="password" id="password"
								placeholder="Password" required></th>
						</tr>
					</tbody>
				</table>
			</form>

			<div class="col-11">
				<form action="/updateUser" method="post">
					<table class="table table-striped table-bordered" id="tblData">
						<thead>
							<tr>
								<h1>Edit a User</h1>
							<tr>
								<th><input type="text" name="id"
									placeholder="ID of the User to update" required></th>
								<th><select name="role">
										<option value="" disabled selected>Account Type</option>
										<option value="USER">User</option>
										<option value="ADMIN">Admin</option>
								</select></th>
								<th><input type="submit" value="Update"></th>
						</thead>
						<tbody>
							<tr>
								<th><input type="text" name="firstname"
									placeholder="First Name" required></th>
								<th><input type="text" name="lastname"
									placeholder="Last Name" required></th>
								<th><input type="text" name="username"
									placeholder="Username" required></th>
								<th><input type="email" name="email" placeholder="Email"
									required></th>
								<th><input type="password" name="password"
									placeholder="Password" required></th>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<footer class="page-footer font-small indigo" id="footer"
			style="width: 100%">
			<!-- Copyright -->
			<div class="footer-copyright text-center py-3">
				Copyright © 2021 Designed by <span> <a href="localhost:8080/">The
						Coolest Team!</a> All rights reserved.
				</span> <a href="/manageusers">Back to top</a>
			</div>
		</footer>
		<script>
			var element = document.getElementById("footer");
			var rect = element.getBoundingClientRect();
			var w = window.innerWidth;
			var h = window.innerHeight;

			console.log(rect.top, rect.bottom);
			console.log(w + " " + h);
			if (rect.bottom <= h) {
				element.style = "position: fixed; bottom: 0; width:100%";
			}
			//console.log(x);
			rect = element.getBoundingClientRect();
			console.log(rect.top, rect.bottom);
			console.log(w + " " + h);
			var count = 0;
			window.onresize = reportWindowSize;
			function reportWindowSize() {
				console.log("hi");
				count++;
				element.style = "position:width:100%";
				if (count != 1) {
					rect = element.getBoundingClientRect();
					h = window.innerHeight;
					console.log(rect.bottom + " " + h);
					if (rect.bottom <= h) {
						element.style = "position: fixed; bottom: 0; width:100%";
					} else {
						element.style = "position:width:100%";
					}
				}
			}
		</script>
</body>
<script src="/javascript/search.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
	crossorigin="anonymous"></script>
</html>