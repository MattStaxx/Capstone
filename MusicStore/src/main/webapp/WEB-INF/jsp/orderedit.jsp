<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
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
</head>
<body>
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
					<li><a href="home" class="nav-link px-2 text-white">Home</a></li>
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

		<h2>
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
		</h2>

		<form action="/manageorders">
			<input type="submit" value="Back To Order Management" />
		</form>

		<div class="container">
			<br /> <br />
			<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<tr>
						<h1>Order #${order.id} Products:</h1>
					</tr>
					<tr>
						<th scope="col">Id</th>
						<th scope="col">Image</th>
						<th scope="col">Category</th>
						<th scope="col">Title</th>
						<th scope="col">Artist</th>
						<th scope="col">Style</th>
						<th scope="col">Format</th>
						<th scope="col">Price</th>
						<th scope="col">Genre</th>
						<th scope="col">Quantity</th>
						<th scope="col">Customer</th>
						<th></th>
					</tr>
					<c:forEach items="${products}" var="product">
						<tr>
							<td><c:out value="${product.id}" /></td>
							<td><img src="${product.imageurl}" alt="${product.title}"
								width="100" height="100" class="img-thumbnail rounded-square"></td>
							<td><c:out value="${product.category}" /></td>
							<td><c:out value="${product.title}" /></td>
							<td><c:out value="${product.artist}" /></td>
							<td><c:out value="${product.style}" /></td>
							<td><c:out value="${product.format}" /></td>
							<td><c:out value="${product.price}" /></td>
							<td><c:out value="${product.genre}" /></td>
							<td><c:out value="${product.quantity}" /></td>
							<td><c:out value="${order.customer.getUsername()}" /></td>
							<td>
								<form action="/deleteProduct" method="post"">
									<input type="hidden" name="orderid" value="${order.id}">
									<input type="hidden" name="id" value="${product.id}"> <input
										type="submit" value="Delete">
								</form>
							</td>
						</tr>
					</c:forEach>
				</thead>
				<tbody>
				</tbody>
			</table>

			<div class="container">
				<form action="/addProduct" method="post">
					<table class="table table-striped table-bordered" id="tblData">
						<thead>
							<tr>
								<h1>Add a Product</h1>
							</tr>
							<tr>
								<input type="hidden" name="orderid" value="${order.id}">
								<input type="submit" value="Add">
						</thead>
						<tbody>
							<tr>
								<th><input type="text" name="title" placeholder="Title"
									required></th>

								<th><select id="imageurl" onchange="changeGenre()"
									name="imageurl" required>
										<option>Select Genre</option>
										<option value="images/rock.jpg">Rock</option>
										<option value="images/electronic.jpg">Electronic</option>
										<option value="images/rap.jpg">Rap</option>
										<option value="images/hiphop.jpg">Hip Hop</option>
										<option value="images/violin.jpg">Classical</option>
										<script>
											function changeGenre() {
												var x = document
														.getElementById("imageurl");
												console
														.log(x.options[x.selectedIndex].text);
												var genre = document
														.getElementById("genre");
												genre.value = x.options[x.selectedIndex].text;
											}
										</script>
								</select></th>
								<th><input type="text" name="category"
									placeholder="Category"></th>
								<th><input type="text" name="artist" placeholder="Artist"></th>
								<th><input type="text" name="style" placeholder="Style"></th>
								<th><input type="text" name="format" placeholder="Format"
									required></th>
								<th><input type="number" step="0.01" name="price"
									placeholder="Price" required></th>
								<th><input type="number" name="quantity"
									placeholder="Quantity" required></th>
								<th><input type="hidden" name="genre" id="genre"
									placeholder="Genre"></th>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="container">
				<form action="/updateProduct" method="post">
					<table class="table table-striped table-bordered" id="tblData">
						<thead>
							<tr>
								<h1>Edit a Product</h1>
							<tr>
								<th><input type="hidden" name="orderid" value="${order.id}">
									<input type="text" name="id"
									placeholder="ID of the Product to update" required>
							<tr>
								<input type="submit" value="Update">
						</thead>
						<tbody>
							<tr>
								<th><input type="text" name="title" placeholder="Title"
									required></th>
								<th><select name="imageurl">
										<option value="images/rock.jpg">Rock</option>
										<option value="images/electronic.jpg">Electronic</option>
										<option value="images/rap.jpg">Rap</option>
										<option value="images/hiphop.jpg">Hip Hop</option>
										<option value="images/violin.jpg">Classical</option>
								</select></th>
								<th><input type="text" name="category"
									placeholder="Category"></th>
								<th><input type="text" name="artist" placeholder="Artist"
									required></th>
								<th><input type="text" name="style" placeholder="Style"
									required></th>
								<th><input type="text" name="format" placeholder="Format"
									required></th>
								<th><input type="number" step="0.01" name="price"
									placeholder="Price" required></th>
								<th><input type="text" name="genre" placeholder="Genre"
									required></th>
								<th><input type="number" name="quantity"
									placeholder="Quantity" required></th>
							</tr>
						</tbody>
					</table>
				</form>
			</div>


		</div>
	</div>
	<footer class="page-footer font-small indigo" id="footer"
		style="width: 100%">
		<!-- Copyright -->
		<div class="footer-copyright text-center py-3">
			Copyright © 2021 Designed by <span> <a href="/about">The
					Coolest Team!</a> All rights reserved.
			</span> <a href="/orderedit">Back to top</a>
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