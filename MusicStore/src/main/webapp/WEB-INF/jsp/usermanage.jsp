<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hcl.MusicStore.entities.MusicUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<link rel="stylesheet" href="css/style.css">

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
			<li><a class="active" href="manageusers">Manage Users</a></li>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<li><a href="logout">Logout</a></li>
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
		<br /> <br />
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>List of All Users</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Username</th>
					<th scope="col">Email</th>
					<th scope="col">Password</th>
					<th scope="col">Role</th>
					<th></th>
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
						<td>
							<form action="/deleteUser" method="post"">
								<input type="hidden" name="id" value="${user.id}">
								<input type="submit" value="Delete">
							</form>
						</td>
					</tr>
				</c:forEach>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		<div style="color: #0000FF;">${successMessage}</div>
		<div style="color: #FF0000;">${errorMessage}</div>
		
		<form action="/addUser" method="post"">	
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Add a User</h1></tr>
				<tr>		
					<th><input type="text" name="firstname" id="firstname" placeholder="First Name" required></th>
					<th><input type="text" name="lastname" id="lastname" placeholder="Last Name" required></th>
					<th><input type="text" name="username" id="username" placeholder="Username" required></th>
					<th><input type="email" name="email" id="email" placeholder="Email" required></th>
					<th><input type="password" name="password" id="password" placeholder="Password" required></th>
					<th>
						<select name="role" id="role">
					  	<option value="" disabled selected>Account Type</option>
			 		  	<option value="USER">User</option>
 					  	<option value="ADMIN">Admin</option>
					  	</select></th>
					<th><input type="submit" value="Add"></th>
				</tr>
			</thead>
		</form>
		
		<form action="/updateUser" method="post"">
			<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Edit a User</h1></td>
				<tr>
					<th><input type="text" id="id" placeholder="ID of the User to update" required></th>	
				<tr>
					<th><input type="text" id="firstname" placeholder="First Name" required></th>
					<th><input type="text" id="lastname" placeholder="Last Name" required></th>
					<th><input type="text" id="username" placeholder="Username" required></th>
					<th><input type="email" id="email" placeholder="Email" required></th>
					<th><input type="password" id="password" placeholder="Password" required></th>
					<th><select name="severity" id="severity">
					  <option value="" disabled selected>Account Type</option>
			 		  <option value="USER">User</option>
 					  <option value="ADMIN">Admin</option>
					</select></th>
					<th><input type="submit" value="Update"></th>
				</tr>
				</tr>
			</thead>
		</form>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>