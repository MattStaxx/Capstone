<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.0.3.min.js"></script>   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Loginr</title>
</head>
<body>
<div class="user-form">
		<h1>Sign in</h1>
		<form action="/performLogin" method="post"">
			<div style="color: #0000FF;">${successMessage}</div>
			<div style="color: #FF0000;">${errorMessage}</div>
			<input type="text" name="username" id="username" placeholder="Username" required> 
			<input type="password" name="password" id="password" placeholder="Password" required> 
			<input type="submit" value="Login">
		</form>
		<hr>
		</form>
			<form action="/register" method="get">
			<input type="submit" value="Register">
		</form>
	</div>
</body>
</html>