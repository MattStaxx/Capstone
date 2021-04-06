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
<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">


<ordernumber>Manage Inventory</ordernumber>
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
			<li><a href="manageinventory">Manage Inventory</a></li>
			<li><a class="active" href="manageorders">Manage Orders</a></li>
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
			delete logged in Order!</b> <br />
	</div>

	<div id="deleteSuccessMessage"
		style="visibility: hidden; text-align: center;">
		<br /> <b style="color: red; text-align: center">Order Successfully
			Deleted!</b> <br />
	</div>

	<div class="container">
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">Order Number</th>
					<th scope="col">Status</th>
					<th scope="col">Items</th>
					<th scope="col">Customer</th>
				</tr>
				
			</thead>
			<tbody>
				<c:forEach items="${orders}" var="order">
					<tr>
						<td><c:out value="${order.id}" /></td>
						<td><c:out value="${order.orderNumber}" /></td>
						<td><c:out value="${order.status}" /></td>
						<td><c:out value="${order.products}" /></td>
						<td><c:out value="${order.customer}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div style="color: #0000FF;">${successMessage}</div>
		<div style="color: #FF0000;">${errorMessage}</div>
		
		<form action="/addOrder" method="post"">	
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Add an Order</h1></tr>
				<tr>		
					<th><input type="number" name="ordernumber" placeholder="Order Number" ></th>
					<th><select name="status" id="status">
					  <option value="" disabled selected>Status</option>
			 		  <option value="ORDERED">Ordered</option>
 					  <option value="SHIPPED">Shipped</option>
 					  <option value="DELIVERED">Delivered</option>
					</select></th>
					<th><input type="text" name="products" placeholder="Products [TODO]" required></th>
					<th><input type="text" name="user" placeholder="user"></th>
					<th><input type="submit" value="Add"></th>
				</tr>
			</thead>
		</form>
		
		<form action="/deleteOrder" method="post"">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Delete an Order</h1></tr>
				<tr>		
					<th><input type="number" name="id" placeholder="Order Number to Delete" required></th>
					<th><input type="submit" value="Delete"></th>
				</tr>
			</thead>
		</form>
		
		<form action="/updateOrder" method="post"">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Edit an Order</h1></td>
				<tr>
					<th><input type="text" id="id" placeholder="ID of the Order to update" required></th>	
				<tr>		
					<th><input type="text" name="id" placeholder="id" required></th>
					<th><input type="number" name="ordernumber" placeholder="Order Number" ></th>
					<th><select name="status" id="status">
					  <option value="" disabled selected>Status</option>
			 		  <option value="ORDERED">Ordered</option>
 					  <option value="DELIVERED">Shipped</option>
 					  <option value="SHIPPED">Delivered</option>
					</select></th>
					<th><input type="text" name="products" placeholder="Products [TODO]" required></th>
					<th><input type="text" name="user" placeholder="user"></th>
					<th><input type="submit" value="Update"></th>
				</tr>
				</tr>
			</thead>
		</form>
	</div>
</body>
</html>