<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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


<title>Catalog</title>
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



	<!-- Search Catalog Forms -->
	<div id="divId1" align=right style="margin-right: 10px">
		<!-- Search for everything but Price-->
		<form action="search" id="search1">
			<label for="options"> Search By: </label> <select id="options1"
				name="options">
				<option value="artist">Artist Name</option>
				<option value="format">Music Format</option>
				<option value="genre">Genre</option>
				<option value="style">Style</option>
				<option value="title">Title</option>
				<option value="category">Category</option>
				<option value="price">Price</option>
			</select> <input type="text" id="name" name="name" required> <input
				type="submit" value="Search">
		</form>

		<form action="searchprice" id="search2">
			<label for="options"> Search By: </label> <select id="options2"
				name="options">
				<option value="artist">Artist Name</option>
				<option value="format">Music Format</option>
				<option value="genre">Genre</option>
				<option value="style">Style</option>
				<option value="title">Title</option>
				<option value="category">Category</option>
				<option value="price">Price</option>
			</select> <input type="number" id="lowerprice" name="lowerprice"
				placeholder="min" required> <input type="number"
				id="higherprice" name="higherprice" placeholder="max" required>
			<input type="submit" value="Search">
		</form>
	</div>
	<script>
		var x = document.getElementById("search1");
		var xx = document.getElementById("options1");
		var x2 = document.getElementById("search2");
		var xx2 = document.getElementById("options2");
		var y = document.getElementById("divId1");

		var count = 0;
		var count2 = 0;
		var currentState = false;
		var currentState2 = false;
		var option1A = document.getElementById("options1");
		option1A.addEventListener("change", function() {

			if (this.value == "price") {
				y.removeChild(x);
				xx2.selectedIndex = "6";
				y.appendChild(x2);
			}

		});

		var option1B = document.getElementById("options2");
		option1B.addEventListener("change", function() {
			console.log(this.value);
			if (this.value != "price") {
				y.removeChild(x2);
				if (this.value == "artist") {
					xx.selectedIndex = "0";
				} else if (this.value == "format") {
					xx.selectedIndex = "1";
				} else if (this.value == "genre") {
					xx.selectedIndex = "2";
				} else if (this.value == "style") {
					xx.selectedIndex = "3";
				} else if (this.value == "title") {
					xx.selectedIndex = "4";
				} else if (this.value == "category") {
					xx.selectedIndex = "5";
				}

				y.appendChild(x);
			}

		});
		console.log("zzzz");
		y.removeChild(x2);
	</script>
	<br>
	<br>

	<div class="container">
		<div class="productlist">
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
			<table class="table table-hover">
			<thead>
				<tr>
					<th></th>
					<th scope="col">Artist</th>
					<th scope="col">Genre</th>
					<th scope="col">Title</th>
					<th scope="col">Price</th>
					<th scope="col"></th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${Product}" var="product">
					<tr>
						<td><img src="${product.imageurl}" alt="${product.title}" class="img-thumbnail"></td>
						</tr>
						<tr>
						<td>${product.artist}</td>
						<td>${product.genre}</td>
						<td>${product.title}</td>
						<td>${product.price}</td>
						<td>
							<form action="details">

								<input type="hidden" id="idnumber" name="idnumber"
									value="${product.id }"> <input type="submit"
									value="Details">
							</form>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
        	    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" 
        	    crossorigin="anonymous"></script>
</html>