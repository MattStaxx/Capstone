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
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
	    	  rel="stylesheet" 
	    	  integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
	    	  crossorigin="anonymous">
	  	<link rel="stylesheet" href="css/style.css">
	</head>
	<body>
		<h1 class="display-1">The Music Store:Admin Side</h1>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="home">Home</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
		      <div class="navbar-nav">
			        <a class="nav-link" href="catalog">Catalog</a>
			        <a class="nav-link" href="about">About</a>
		    	<sec:authorize access="isAuthenticated()">
					<a class="nav-link" href="shoppingcart">Cart</a>
					<a class="nav-link" href="orderhistory">Order History</a>
					<a class="nav-link" href="profile">Profile</a>
		    	</sec:authorize>
		    	
		    	<sec:authorize access="hasAnyRole('ADMIN')">
			    	 <a class="nav-link" href="admin">Admin</a>
			    	 <a class="nav-link" href="manageinventory">Manage Inventory</a>
					 <a class="nav-link" href="manageorders">Manage Orders</a>
			    	 <a class="nav-link" href="manageusers">Manage Users</a>
				</sec:authorize>
		    	
		    	<sec:authorize access="!isAuthenticated()">
	    			 <a class="nav-link" href="login"  >Login</a>
	    			 <a class="nav-link" href="register">Register</a>
				</sec:authorize>
				
		    	<sec:authorize access="isAuthenticated()">
		    	    	   <a class="nav-link" href="logout" >Logout</a>
		    	</sec:authorize>
		      </div>
		    </div>
		  </div>
		</nav>
	
		<h2>
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
		</h2>
		
		<div class="container">
		<div>
			<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<tr><h1>List of All Orders</h1></tr>
					<tr>		
						<th scope="col">Order Id</th>
						<th scope="col">Status</th>
						<th scope="col">Customer Username</th>
						<th scope="col"># Products Ordered</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orders}" var="order">
						<tr>
							<td><c:out value="${order.id}" /></td>
							<td><c:out value="${order.status}" /></td>
							<td><c:out value="${order.customer.getUsername()}" /></td>
							<td><c:out value="${order.products.size()}" /></td>
							<td>
								<form action="/editOrder" method="post">
									<input type="hidden" name="id" value="${order.id}">
									<input type="submit" value="Edit Products">
								</form>
								<form action="/deleteOrder" method="post">
									<input type="hidden" name="id" value="${order.id}">
									<input type="submit" value="Delete Order">
								</form>
							</td>
						</tr>
						<!-- Print out all products
						<tr>
							<td>Products: ${order.products.size()}</td>
						</tr>
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
							<c:forEach items="${order.products}" var="product">
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
						<tr><td><hr></td><tr> -->
					</c:forEach>
				</tbody>
			</table>
			</div>
			<div>
			<form action="/addOrder" method="post">	
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
						<th><input type="text" name="user" placeholder="Customer"></th>
						<th><input type="submit" value="Add"></th>
					</tr>
				</thead>
			</table>
			</form>
			</div>
			<div>
			<form action="/updateOrderStatus" method="post">
				<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<tr><h1>Update Order Status</h1></td>
					<tr>
						<th><input type="text" name="id" placeholder="Order Id" required></th>	
					<tr>		
						<th><select name="status" id="status">
						  <option value="" disabled selected>Status</option>
				 		  <option value="ORDERED">Ordered</option>
				 		  <option value="SHIPPED">Shipped</option>
	 					  <option value="DELIVERED">Delivered</option>	  
						</select></th>
						<th><input type="submit" value="Update"></th>
				</thead>
			</table>
			</form>
		</div>
	</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>