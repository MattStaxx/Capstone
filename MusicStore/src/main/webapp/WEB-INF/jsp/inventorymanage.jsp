<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">


<title>Manage Inventory</title>
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

		<!-- Order View -->
		<sec:authorize access="isAuthenticated()">
			<li><a href="shoppingcart">Cart</a></li>
			<li><a href="orderhistory">Order History</a></li>
			<li><a href="profile">Profile</a></li>
		</sec:authorize>

		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
			<li><a class="active" href="manageinventory">Manage Inventory</a></li>
			<li><a href="manageorders">Manage Orders</a></li>
			<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<li><a href="logout">Logout</a></li>
		</sec:authorize>
	</ul>


	<div id="emptyFieldErrorMessage"
		style="display: none; text-align: center;">
		<br /> <b style="color: red; text-align: center">Error: Missing
			required information!</b> <br />
	</div>

	<div id="deleteErrorMessage"
		style="visibility: hidden; text-align: center;">
		<br /> <b style="color: red; text-align: center">Error: Cannot
			delete logged in Product!</b> <br />
	</div>

	<div id="deleteSuccessMessage"
		style="visibility: hidden; text-align: center;">
		<br /> <b style="color: red; text-align: center">Product Successfully
			Deleted!</b> <br />
	</div>

	<div class="container">
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>List of All Products</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">Title</th>
					<th scope="col">Artist</th>
					<th scope="col">Style</th>
					<th scope="col">Format</th>
					<th scope="col">Price</th>
					<th scope="col">Genre</th>
					<th scope="col">Quantity</th>
				</tr>
				<c:forEach items="${products}" var="product">
					<tr>
						<td><c:out value="${product.id}" /></td>
						<td><c:out value="${product.title}" /></td>
						<td><c:out value="${product.artist}" /></td>
						<td><c:out value="${product.style}" /></td>
						<td><c:out value="${product.format}" /></td>
						<td><c:out value="${product.price}" /></td>
						<td><c:out value="${product.genre}" /></td>
						<td><c:out value="${product.quantity}" /></td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		<div style="color: #0000FF;">${successMessage}</div>
		<div style="color: #FF0000;">${errorMessage}</div>
		
		<form action="/addProduct" method="post"">	
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Add a Product</h1></tr>
				<tr>		
					<th><input type="text" name="title" placeholder="Title" required></th>
					<th><input type="text" name="artist" placeholder="Artist" ></th>
					<th><input type="text" name="style" placeholder="Style" ></th>
					<th><input type="text" name="format" placeholder="Format" required></th>
					<th><input type="number" step="0.01" name="price" placeholder="Price" required></th>
					<th><input type="text" name="genre" placeholder="Genre"></th>
					<th><input type="number" name="quantity" placeholder="Quantity" required></th>
					<th><input type="submit" value="Add"></th>
				</tr>
			</thead>
		</form>
		
		<form action="/deleteProduct" method="post"">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Delete a Product</h1></tr>
				<tr>		
					<th><input type="number" name="id" placeholder="ID to Delete" required></th>
					<th><input type="submit" value="Delete"></th>
				</tr>
			</thead>
		</form>
		
		<form action="/updateProduct" method="post"">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Edit a Product</h1></td>
				<tr>
					<th><input type="number" name="id" placeholder="ID of the Product to update" required></th>	
				<tr>
					<th><input type="text" name="title" placeholder="Title" required></th>
					<th><input type="text" name="artist" placeholder="Artist" required></th>
					<th><input type="text" name="style" placeholder="Style" required></th>
					<th><input type="text" name="format" placeholder="Format" required></th>
					<th><input type="number" step="0.01" name="price" placeholder="Price" required></th>
					<th><input type="text" name="genre" placeholder="Genre" required></th>
					<th><input type="number" name="quantity" placeholder="Quantity" required></th>
					<th><input type="submit" value="Update"></th>
				</tr>
				</tr>
			</thead>
		</form>
	</div>
	
	
	
</body>
</html>