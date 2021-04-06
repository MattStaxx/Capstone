<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.0.3.min.js"></script>   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Order Confirmation</title>
</head>
<body>
	<h1>Checkout</h1>
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
 			<li><a href="profile">Profile</a></li>
 			<li><a href="logout">Logout</a></li>
		</sec:authorize>
		
		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
    		<li><a href="admin">Admin</a></li>
    		<li><a href="manageinventory">Manage Inventory</a></li>
    		<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
 			<li><a class="active" href="Checkout">Checkout</a></li>
 			<li><a href="logout">Logout</a></li>
		</sec:authorize>
	</ul>

	<div class="container">
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Your Order</h1></tr>
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
				<c:set var="total" value="${0}"/>
				<c:forEach items="${cart}" var="product">
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
					<c:set var="total" value="${total + product.price}" />
				</c:forEach>
				<tr>Your Total: ${total}</tr>
				<tr>
					<form action="/checkout" method="post">	
					<input type="submit" value="Checkout"></form>
				</tr>
			</thead>
		</table>
	</div>
</html>