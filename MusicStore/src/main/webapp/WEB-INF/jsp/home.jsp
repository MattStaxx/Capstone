<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
  <head>
  	<link rel="stylesheet" href="css/style.css">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
        crossorigin="anonymous">
		<style type="text/css" media="screen">
		   #background1 {
		      background-image: url(../images/beats.jpg);
		      background-repeat: no-repeat;
		      background-position: left top;
		      padding-top:68px;
		      margin-bottom:50px;
		   }
		</style>

    <title>Homepage</title>
  </head>
  <body>
    <ul>	
		<li><a class="active" href="home">Home</a></li>
		<li><a href="catalog">Catalog</a></li>
		<li><a href="about">About</a></li>
		
		<!-- Not logged in -->
		<sec:authorize access="!isAuthenticated()">
 			<li><a href="login">Login</a></li>
			<li><a href="register">Register</a></li>
		</sec:authorize>
		
		<!-- User View -->
		<sec:authorize access="isAuthenticated()">
			<li><a href="shoppingcart">Cart</a></li>
			<li><a href="orderhistory">Order History</a></li>
 			<li><a href="profile">Profile</a></li>
 			<li><a href="logout">Logout</a></li>
		</sec:authorize>
		
		<!-- Admin View -->
		<sec:authorize access="hasAnyRole('ADMIN')">
    		<li><a href="admin">Admin</a></li>
    		<li><a href="manageinventory">Manage Inventory</a></li>
    		<li><a href="manageusers">Manage Users</a></li>
		</sec:authorize>
	</ul>
	<div class="container-fluid" id="background1"></div>                                                  
	
        
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
      
    </body>
</html>