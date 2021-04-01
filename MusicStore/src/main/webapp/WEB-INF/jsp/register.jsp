<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<div class="user-form">
		<h1>Register Form</h1>
		<form action="/register" method="POST">
			<div style="color: #FF0000;">${errorMessage}</div>
			<input type="text" name="firstname" placeholder="First Name" required>
			<input type="text" name="lastname" placeholder="Last Name" required>
			<input type="text" name="username" placeholder="Username" required>
			<input type="email" name="email" placeholder="Email" required>
			<input type="password" name="password" placeholder="Password" required>
			<input type="submit" value="Register">
		</form>
		<hr> 
		<form action="/" method="GET">
		<input type="submit" value="Go back to Login Page">
		</form>
	</div class=>

	
</body>
</html>