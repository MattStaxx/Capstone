<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link href="css/main.css" rel="stylesheet">


<title>Profile</title>
</head>
<body>
	<ul>
		<li><a href="home">Home</a></li>
		<li><a href="catalog">Catalog</a></li>
		<li><a href="about">About</a></li>

		<!-- Not logged in -->
		<sec:authorize access="!isAuthenticated()">
			<li><a href="login">Login</a></li>
			<li><a href="register">Register</a></li>
		</sec:authorize>

		<!-- User View -->
		<sec:authorize access="isAuthenticated()">
			<li><a href="shoppingcart">Cart</a></li>
			<li><a href="orderhistory">Order History</a></li>
			<li><a class="active" href="profile">Profile</a></li>
			<li><a href="logout">Logout</a></li>
		</sec:authorize>

		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
			<li><a href="admin">Admin</a></li>
			<li><a href="manageinventory">Manage Inventory</a></li>
			<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
	</ul>

	<h1 class="display-1">Profile Page</h1>


	<div class="container">
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>${username}'s Profile</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">User Name</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Card Number</th>
					<th scope="col">Role</th>
				</tr>
				<c:forEach items="${userdetails}" var="usr">
					<tr>
						<td><c:out value="${usr.id}" /></td>
						<td><c:out value="${usr.firstname}" /></td>
						<td><c:out value="${usr.lastname}" /></td>
						<td><c:out value="${usr.username}" /></td>
						<td><c:out value="${usr.email}" /></td>
						<td><c:out value="${usr.password}" /></td>
						<td><c:out value="${usr.creditcard}" /></td>
						<td><c:out value="${usr.role}" /></td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.3.2.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
</body>
</html>
