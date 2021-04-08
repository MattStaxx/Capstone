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
		<div class="container"></div>

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
				<tr><h1>Order #${order.id} Products:</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">Image</th>
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
						<td><img src="${product.imageurl}" alt="${product.title}" class="img-thumbnail"></td>
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
								<input type="hidden" name="id" value="${product.id}">
								<input type="submit" value="Delete">
							</form>
						</td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		<form action="/addProduct" method="post">	
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Add a Product</h1></tr>
				<tr>	
					<input type="hidden" name="orderid" value="${order.id}" required>
					<th></th>
					<th><input type="text" name="title" placeholder="Title" required></th>
					<th><input type="text" name="imageurl" placeholder="Image URL"></th>
					<th><input type="text" name="artist" placeholder="Artist" ></th>
					<th><input type="text" name="style" placeholder="Style" ></th>
					<th><input type="text" name="format" placeholder="Format" required></th>
					<th><input type="number" step="0.01" name="price" placeholder="Price" required></th>
					<th><input type="text" name="genre" placeholder="Genre"></th>
					<th><input type="number" name="quantity" placeholder="Quantity" required></th>
					<th><input type="submit" value="Add"></th>
				</tr>
			</thead>
			</table>
		</form>
		
		<form action="/updateProduct" method="post">
			<input type="hidden" name="orderid" value="${order.id}" required>
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Edit a Product</h1></td>
				<tr>
					<th><input type="text" name="id" placeholder="ID of the Product to update" required></th>	
				<tr>
					<th><input type="text" name="title" placeholder="Title" required></th>
					<th><input type="text" name="imageurl" placeholder="Image URL"></th>
					<th><input type="text" name="artist" placeholder="Artist" required></th>
					<th><input type="text" name="style" placeholder="Style" required></th>
					<th><input type="text" name="format" placeholder="Format" required></th>
					<th><input type="number" step="0.01" name="price" placeholder="Price" required></th>
					<th><input type="text" name="genre" placeholder="Genre" required></th>
					<th><input type="number" name="quantity" placeholder="Quantity" required></th>
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