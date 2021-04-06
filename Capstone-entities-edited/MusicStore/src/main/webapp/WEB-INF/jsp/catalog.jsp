<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
<link href="css/main.css" rel="stylesheet">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

		

<title>Catalog</title>
</head>
<body>
	<ul>
		<li><a href="home">Home</a></li>
		<li><a class="active" href="catalog">Catalog</a></li>
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
	

	<!-- Search Catalog Forms -->
	<div id="divId1">
		<!-- Search for everything but Price-->
		<form action="search" id="search1">
			<label for="options"> Search By: </label> <select id="options1"
				name="options" >
				<option value="artist" >Artist Name</option>
				<option value="format">Music Format</option>
				<option value="genre">Genre</option>
				<option value="style">Style</option>
				<option value="title">Title</option>
				<option value="price">Price</option>
			</select> 
			<input type="text" id="name" name="name" required> 
			<input type="submit" value="Search">
		</form>
		
		<form action="search" id="search2">
			<label for="options"> Search By: </label> <select id="options2"
				name="options">
				<option value="artist">Artist Name</option>
				<option value="format">Music Format</option>
				<option value="genre">Genre</option>
				<option value="style">Style</option>
				<option value="title">Title</option>
				<option value="price">Price</option>
			</select> 
			<input type="text" id="name" name="name" required> 
			<input type="text" id="name2" name="name2" > 
			<input type="submit" value="Search">
		</form>
</div>



<script>

var x  = document.getElementById("search1");
var xx = document.getElementById("options1");
var x2 = document.getElementById("search2");
var xx2 = document.getElementById("options2");
var y   =document.getElementById("divId1");



var count=0;
var count2=0;
var currentState=false;
var currentState2=false;
var option1A=document.getElementById("options1");
option1A.addEventListener("change",function(){

	if(this.value=="price"){y.removeChild(x);  xx2.selectedIndex="5"; y.appendChild(x2); }

 });

var option1B=document.getElementById("options2");
option1B.addEventListener("change",function(){
console.log(this.value);
	if(this.value!="price"){y.removeChild(x2);
	if(this.value=="artist"){xx.selectedIndex="0";}
	else if(this.value=="format"){xx.selectedIndex="1";}
	else if(this.value=="genre"){xx.selectedIndex="2";}
	else if(this.value=="style"){xx.selectedIndex="3";}
	else if(this.value=="title"){xx.selectedIndex="4";}
	
	y.appendChild(x); }

 });
console.log("zzzz");
y.removeChild(x2);


</script>





	<div>
		<table>
		 <tr>
		   <td> Artist</td>
		   <td> Genre</td>
		   <td> Title</td>
		   <td> Price</td>
		 </tr>
			<c:forEach items="${Product}" var="products">
				<tr>
					<td>${products.artist}</td>
					<td>${products.genre}</td>
					<td>${products.title}</td>
					<td>${products.price}</td>
<!-- 					<td> <form action="details"> -->
<!-- 					 <input type="text" id="productid" name="productid" value=${products.id} > <br> -->
<!-- 			           <input type="submit" value="Details"><br > -->
<!-- 					 </form></td> -->
				</tr>
			</c:forEach>
		</table>
	</div>




</body>
</html>