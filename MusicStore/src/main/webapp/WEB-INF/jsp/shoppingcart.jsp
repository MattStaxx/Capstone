<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

    <title>Shopping Cart</title>
  </head>
<body>
<h1 class="display-1">The Music Store</h1>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="home">Home</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav"">
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
    	 <a class="nav-link" href="manageusers">Manage Orders</a>
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
	<h2 class="display-3">Cart</h2>
	
	<div class="container">
		<table class="table table-striped table-bordered" id="tblData">
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
			<thead>
				<tr><h1>Your Order</h1></tr>
				<tr>		
					<th></th>
					<th scope="col">Id</th>
					<th scope="col">Title</th>
					<th scope="col">Artist</th>
					<th scope="col">Style</th>
					<th scope="col">Format</th>
					<th scope="col">Price</th>
					<th scope="col">Genre</th>
					<th scope="col">Quantity</th>
					<th></th>
				</tr>
				<c:set var="total" value="${0}"/>
				<c:forEach items="${products}" var="product">
					<tr>
						<td><img src="${product.imageurl}" alt="${product.title}" class="img-thumbnail"></td>
						<td><c:out value="${product.id}" /></td>
						<td><c:out value="${product.title}" /></td>
						<td><c:out value="${product.artist}" /></td>
						<td><c:out value="${product.style}" /></td>
						<td><c:out value="${product.format}" /></td>
						<td><c:out value="${product.price}" /></td>
						<td><c:out value="${product.genre}" /></td>
						<td><c:out value="${product.quantity}" /></td>
						<td>
							<form action="/deleteFromCart" method="post"">
								<input type="hidden" name="id" value="${product.id}"> <input
									type="submit" value="Remove">
							</form>
						</td>
					</tr>
					<c:set var="total" value="${total + (product.price * product.quantity)}" />
				</c:forEach>
				
			</thead>
			<tbody>
				
			</tbody>
		</table>
		Your Total: ${total}
		<form action="/payment" method="get">
		<input type="submit" value="Checkout"></form>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
        	    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" 
        	    crossorigin="anonymous"></script>
</html>