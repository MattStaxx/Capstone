<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.0.3.min.js"></script>   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Loginr</title>
</head>
<body>
<link	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"	rel="stylesheet"	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"	crossorigin="anonymous"><link rel="stylesheet" href="css/style.css"><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"         	    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"         	    crossorigin="anonymous"></script> <h1 class="display-1">The Music Store</h1>


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
<div class="user-form">
		<h1>Sign in</h1>
		<form action="/performLogin" method="post">
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
			<input type="text" name="username" id="username" placeholder="Username" required> 
			<input type="password" name="password" id="password" placeholder="Password" required> 
			<input type="submit" value="Login">
		</form>
		<hr>
			<form action="/register" method="get">
			<input type="submit" value="Register">
		</form>
	</div>
</body>
</html>
