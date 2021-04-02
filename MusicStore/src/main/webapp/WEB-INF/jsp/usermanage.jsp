<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hcl.MusicStore.entities.MusicUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">


<title>Manage Users</title>
</head>
<body>
	<ul>
		<li><a href="home">Home</a></li>
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
			<li><a class="active" href="manageusers">Manage Users</a></li>
		</sec:authorize>
	</ul>


	<div id="emptyFieldErrorMessage"
		style="display: none; text-align: center;">
		<br /> <b style="color: red; text-align: center">Error: Missing
			required information!</b> <br />
	</div>

	<div id="deleteErrorMessage"
		style="visibility: hidden; text-align: center;">
		<br /> <b style="color: red; text-align: center">Error: Cannot
			delete logged in User!</b> <br />
	</div>

	<div id="deleteSuccessMessage"
		style="visibility: hidden; text-align: center;">
		<br /> <b style="color: red; text-align: center">User Successfully
			Deleted!</b> <br />
	</div>

	<div class="container">
		<button type="button" id="btnAdd" class="btn btn-default btn-sm">
			<span class="glyphicon glyphicon-plus"></span> Add User
		</button>
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Username</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Role</th>
				</tr>
				<c:forEach items="${users}" var="user">
					<tr>
						<td><c:out value="${user.id}" /></td>
						<td><c:out value="${user.firstname}" /></td>
						<td><c:out value="${user.lastname}" /></td>
						<td><c:out value="${user.username}" /></td>
						<td><c:out value="${user.email}" /></td>
						<td><c:out value="${user.password}" /></td>
						<td><c:out value="${user.role}" /></td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</body>
</html>