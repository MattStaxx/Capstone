<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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
    	  
		<style type="text/css" media="screen">
		
		#background1 {		
			background-image: url(/images/headphones2.jpg);
			background-repeat: no-repeat;
			background-position: center top;
			padding-top:50px;
			height: 92vh;
		   }
		   
		.carousel-inner > .item > img,  
		.carousel-inner > .item > a > img { 
			max-width: 100%; 
			height: 91vh;
			margin: auto;  
		    }  
		    
	    .carousel-indicators .active {
	    	background-color: green;
	    }
		    
		</style>

    <title>Homepage</title>
  </head>
  <body style="background-color: rgb(2, 8, 1);">    
	<ul>
		<li><a class="active" href="home">Home</a></li>
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
			<li><a href="manageorders">Manage Orders</a></li>
			<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<li><a href="logout">Logout</a></li>
		</sec:authorize>	
	</ul>
        <h1 class="display-1">TODO</h1>                                          
	
	 <div class="container" style="background-color: rgb(2, 8, 1);" >
	  <div id="carouselExampleIndicators" class="carousel slide carousel carousel-fade" data-bs-ride="carousel">
	    <div class="carousel-inner" style="height:91vh; margin-left:auto; margin-right:auto;">
	      <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
	      <div class="carousel-item active">
	      	<img alt="no image" class="image-fluid" src="images/guitar.jpg">
	          
	      </div>
	        <div class="carousel-item">
	          <img alt="no image" class="image-fluid" src="images/bluecomp.jpg">
	            
	        </div>
	        <div class="carousel-item">
	          <img alt="no image" class="image-fluid" src="images/headphones2.jpg">
	           
	        </div>
	    </div>
		    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev" ></button>
		    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next"></button>
	  </div>
	</div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
        	    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" 
        	    crossorigin="anonymous"></script>
</html>