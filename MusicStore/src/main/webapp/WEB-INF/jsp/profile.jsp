<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
    	  rel="stylesheet" 
    	  integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
    	  crossorigin="anonymous">
  	<link rel="stylesheet" href="css/style.css">
<title>Profile</title>
</head>
	<body>
		<h1 class="display-1">${user.username}'s Profile</h1>
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
	
		<div class="container">
		<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<tr>		
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
						<th scope="col">Password</th>
						<th scope="col">Card Number</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userdetails}" var="usr">
						<tr>
							<td><c:out value="${usr.firstname}" /></td>
							<td><c:out value="${usr.lastname}" /></td>
							<td><c:out value="${usr.email}" /></td>
							<td><c:out value="******" /></td>
							<td><c:out value="${usr.creditcard}" /></td>
						</tr><br><br>
					</c:forEach>
				</tbody>
			</table>
		<div class="container">
		<table class="table table-striped table-bordered" id="tblData">
				<thead>
					
				</thead>
				</table>
				</div>
			<form action="/updateProfile" method="post">
				<table class="table table-striped table-bordered" id="tblData">
				<thead>
				<h2>New Values</h2>
					<tr>		
						<th scope="col">First Name</th>
						<th scope="col">Last Name</th>
						<th scope="col">Email</th>
						<th scope="col">Password</th>
						<th scope="col">Card Number</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th><input type="text" name="firstname" placeholder="First Name" value="${user.firstname}" required></th>
						<th><input type="text" name="lastname" placeholder="Last Name" value="${user.lastname}"></th>
						<th><input type="text" name="email" placeholder="Email" value="${user.email}"></th>
						<th><input type="text" name="password" placeholder="Password" required></th>
						<th><input type="text" name="creditcard" placeholder="Card Number" value="${user.creditcard}"></th>
						<input type="hidden" name="id" placeholder="ID of the Product to update" required>
						<input type="hidden" name="role" placeholder="Role" value="${user.role}" required>
						<input type="hidden" name="username" placeholder="User Name" value="${user.username}" required>
						<th><input type="submit" value="Update"></th>
					</tr>
				</tbody>
				</table>
			</form>
		</div>
	</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>
