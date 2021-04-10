<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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

<title>Home Page</title>
</head>
<body style="background-color: #232a2e;">
	<header>
		<nav class="p-3 text-white">
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
	</header>
	<div class="container-carousel" style="background-color: #232a2e;">
		<div id="carouselExampleIndicators"
			class="carousel slide carousel carousel-fade" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
				</div>
				<div class="carousel-inner" role="listbox">
					<div class="carousel-item active">
						<img alt="no image" class="image-fluid"
							src="images/turntable1-1280.jpg" style="width: 100%">
						<div class="carousel-caption d-sm-block align-items bottom">
							<h5>Search all your favorite genres</h5>
							<a href="/catalog" class="btn btn-primary"
								rel="noopener noreferrer">See the Catalog!</a>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<img alt="no image" class="image-fluid"
						src="images/audiojack2-1280.jpg" style="width: 100%">
					<div class="carousel-caption d-sm-block align-items bottom">
						<h5>
							Our quick and easy registration process will give you access to <br>all
							your favorite songs from all your favorite artists!
						</h5>
						<a href="/register" class="btn btn-primary"
							rel="noopener noreferrer">Register an Account Now!</a>
					</div>
				</div>
				<div class="carousel-item">
					<img alt="no image" class="image-fluid"
						src="images/headphones1-1280.jpg" style="width: 100%">
					<div class="carousel-caption d-sm-block align-items bottom">
						<h5>Learn more about the team that brought you your favorite
							music service!</h5>
						<a href="/about" class="btn btn-primary" rel="noopener noreferrer">Meet
							the team!</a>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev"></button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next"></button>
		</div>
	</div>
	<div class="row w-2">
		<div class="col-md-12 justify-content-center"
			style="text-align: center;">
			<h5 style="color: white;">
				Images on this site sourced<br>from Pixabay.com
			</h5>
			<img src="images/thumbsup.png" alt="Thanks!" width="105" height="105"
				class="rounded-square">
			<h2 style="color: white;">Thanks Pixabay!</h2>
			<a class="btn btn-secondary"
				href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=690685">Pixabay.com</a>
		</div>
	</div>
	<footer class="page-footer font-small indigo" id="footer"
		style="width: 100%">
		<!-- Copyright -->
		<div class="footer-copyright text-center py-3">
			Copyright © 2021 Designed by <span> <a href="/about">The
					Coolest Team!</a> All rights reserved.
			</span> <a href=".">Back to top</a>
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