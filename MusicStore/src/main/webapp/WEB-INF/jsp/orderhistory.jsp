<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<li><a class="active" href="orderhistory">Order History</a></li>
			<li><a href="profile">Profile</a></li>
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

	<h1 class="display-1">Order History</h1>
	<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr>		
					<th scope="col">Order Id</th>
					<!-- <th scope="col">Order Number</th> Hidden for now-->
					<th scope="col">Status</th>
					<th scope="col">Items</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orders}" var="order">
					<tr>
						<td><c:out value="${order.id}" /></td>
						<!-- <td><c:out value="${order.orderNumber}" /></td> Hidden for now-->
						<td><c:out value="${order.status}" /></td>
						<td><c:out value="${order.products.size()}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>