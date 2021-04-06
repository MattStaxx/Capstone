<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

<title>Catalog</title>
</head>
<body>
	<ul>
		<li><a href="home">Home</a></li>
		<li><a class="active" href="catalog">Catalog</a></li>
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
			<li><a href="profile">Profile</a></li>
			<li><a href="logout">Logout</a></li>
		</sec:authorize>

		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
			<li><a href="admin">Admin</a></li>
			<li><a href="manageinventory">Manage Inventory</a></li>
			<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
	</ul>
	

	<!-- Search Catalog Forms -->
	<div>
		<!-- Search for everything but Price-->
		<form action="search">
			<label for="options"> Search By: </label> <select id="options"
				name="options">
				<option value="artist">Artist Name</option>
				<option value="format">Music Format</option>
				<option value="genre">Genre</option>
				<option value="style">Style</option>
				<option value="title">Title</option>
			</select> <input type="text" id="name" name="name" required> 
			<input type="submit" value="Search">
		</form>

		<!-- Search by Price -->
		<form action="searchprice">
		    <label for="lowerprice"> Search by Price: </label> <br> Max:
			<input type="number" id="lowerprice" name="lowerprice" required> Min:
			  <input type="number" id="higherprice"
				name="higherprice" required> <input
				type="submit" value="Search"><br>
		</form>

	</div>

	<div>
		<table>
		 <tr>
		   <td> Artist</td>
		   <td> Genre</td>
		   <td> Title</td>
		   <td> Price</td>
		 </tr>
			<c:forEach items="${products}" var="product">
				<tr>
					<td>${product.artist}</td>
					<td>${product.genre}</td>
					<td>${product.title}</td>
					<td>${product.price}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</body>
</html>