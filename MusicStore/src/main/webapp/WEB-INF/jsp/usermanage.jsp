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
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" 
	    	  rel="stylesheet" 
	    	  integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" 
	    	  crossorigin="anonymous">
	  	<link rel="stylesheet" href="css/style.css">
	
	<title>Manage Users</title>
	</head>
	<body>
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
		<div class="col-11">
			<h1 class="display-1">Managing Users</h1>
		
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
		</div>
			<button type="button" id="btnAdd" class="btn btn-default btn-sm"></button>

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
			</thead>
			
				<tbody>
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
								<input type="hidden" name="id" value="${user.id}"> <input
									type="submit" value="Delete">
							</form>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
			
			<div class="col-11">
				<form action="/addUser" method="post">	
					<table class="table table-striped table-bordered" id="tblData">
					<thead>
						<tr><h1>Add a User</h1></tr>
						<tr>
						<th>
							<select name="role" id="role">
						  	<option value="" disabled selected>Account Type</option>
				 		  	<option value="USER">User</option>
	 					  	<option value="ADMIN">Admin</option>
						  	</select>
							<th><input type="submit" value="Add"></th>
					</thead>
					<tbody>
						<tr>		
							<th><input type="text" name="firstname" id="firstname" placeholder="First Name" required></th>
							<th><input type="text" name="lastname" id="lastname" placeholder="Last Name" required></th>
							<th><input type="text" name="username" id="username" placeholder="Username" required></th>
							<th><input type="email" name="email" id="email" placeholder="Email" required></th>
							<th><input type="password" name="password" id="password" placeholder="Password" required></th>
						</tr>
					</tbody>
					</table>
				</form>

		<div class="col-11">
			<form action="/updateUser" method="post">
				<table class="table table-striped table-bordered" id="tblData">
				<thead>
					<tr><h1>Edit a User</h1>
					<tr>
						<th><input type="text" id="id" placeholder="ID of the User to update" required></th>
						<th><select name="severity" id="severity">
						  <option value="" disabled selected>Account Type</option>
				 		  <option value="USER">User</option>
	 					  <option value="ADMIN">Admin</option>
						</select></th>
						<th><input type="submit" value="Update"></th>
				</thead>
				<tbody>	
					<tr>
						<th><input type="text" id="firstname" placeholder="First Name" required></th>
						<th><input type="text" id="lastname" placeholder="Last Name" required></th>
						<th><input type="text" id="username" placeholder="Username" required></th>
						<th><input type="email" id="email" placeholder="Email" required></th>
						<th><input type="password" id="password" placeholder="Password" required></th>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		</div>
	</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>