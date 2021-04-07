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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
    	  rel="stylesheet" 
    	  integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
    	  crossorigin="anonymous">
  	<link rel="stylesheet" href="css/style.css">
<title>Order History</title>
</head>
<body>
   <h1 class="display-1">The Music Store</h1>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark justify-content-center">
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