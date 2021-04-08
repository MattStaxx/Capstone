<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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



<title>Product Details</title>
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
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th></th>
					<th scope="col">Artist</th>
					<th scope="col">Genre</th>
					<th scope="col">Title</th>
					<th scope="col">Style</th>
					<th scope="col">Format</th>
					<th scope="col">In Stock</th>
					<th scope="col">Price</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${products}" var="product">
					<tr>
						<td><img src="${product.imageurl}" alt="${product.title}" class="img-thumbnail"></td>
						<td>${product.artist}</td>
						<td>${product.genre}</td>
						<td>${product.title}</td>
						<td>${product.style}</td>
						<td>${product.format}</td>
						<td>${product.quantity}</td>
						<td>${product.price}</td>
						<td>
							<form action="/addToCart" method="post">
								<input type="hidden" id="idnumber" name="id"
									value="${product.id}"> Quantity <input type="number"
									id="quantity" name="quantity" value="1" required> <input
									type="submit" value="Add to Cart">
							</form>
						</td>
					</tr>
				</c:forEach>
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