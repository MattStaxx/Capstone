<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
  <head>
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<link rel="stylesheet" href="css/style.css">

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
                   
    <form style="text-align:center" action="orderhistory" method="get">   <!-- line 49(here) to line64 is being hijacked for testing -->
		<input type="text" id="username" name="username">                 <!-- this should all go in a profile page or usermanage -->
	
		<input type="submit" value="View Orders">
	</form>
		   
	<table style="text-align:left;width:70%; cellpadding:2px" >
		<tr><th>Order Number</th></tr>
		<c:forEach items="${orderList}" var="ord">
		   <tr>  
		   <td>${ord.id}</td> 
		   </tr>
		   </c:forEach>
		   </table>
		   <br/>                                                          <!-- to here(line 64) -->
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>