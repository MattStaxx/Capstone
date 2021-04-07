<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<link rel="stylesheet" href="css/style.css">
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

		<!-- Order View -->
		<sec:authorize access="isAuthenticated()">
			<li><a href="shoppingcart">Cart</a></li>
			<li><a href="orderhistory">Order History</a></li>
			<li><a class="active" href="profile">Profile</a></li>
		</sec:authorize>

		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
			<li><a href="manageinventory">Manage Inventory</a></li>
			<li><a href="manageorders">Manage Orders</a></li>
			<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<li><a href="logout">Logout</a></li>
		</sec:authorize>
	</ul>

	<h1 class="display-1">Profile Page</h1>
	<div class="container">
	<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>${username}'s Profile</h1></tr>
				<tr>		
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Card Number</th>
				</tr>
				<c:forEach items="${userdetails}" var="usr">
					<tr>
						<td><c:out value="${usr.firstname}" /></td>
						<td><c:out value="${usr.lastname}" /></td>
						<td><c:out value="${usr.email}" /></td>
						<td><c:out value="${usr.password}" /></td>
						<td><c:out value="${usr.creditcard}" /></td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
		<form action="/updateProfile" method="post">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Editing your Profile</h1></td>
				<tr>
					<th><input type="hidden" name="id" placeholder="ID of the Product to update" required></th>	
				<tr>
					<th><input type="text" name="firstname" placeholder="First Name" required></th>
					<th><input type="text" name="lastname" placeholder="Last Name" required></th>
					<th><input type="hidden" name="username" placeholder="User Name" required></th>
					<th><input type="text" name="email" placeholder="Email" required></th>
					<th><input type="text" name="password" placeholder="Password" required></th>
					<th><input type="text" name="creditcard" placeholder="Card Nmuber" required></th>
					<th><input type="hidden" name="role" placeholder="Role" required></th>
					<th><input type="submit" value="Update"></th>
				</tr>
			</thead>
			</table>
		</form>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
