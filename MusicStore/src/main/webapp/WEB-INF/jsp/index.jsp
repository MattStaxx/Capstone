<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.0.3.min.js"></script>   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Music Store</title>
</head>
<body>
<div class="user-form">
		<h1>Welcome!</h1>
		<form action="/login" method="GET"">
			<input type="submit" value="Login">
		</form>
		<hr>
		</form>
			<form action="/register" method="GET">
			<input type="submit" value="Register">
		</form>
		<hr>
		</form>
			<form action="http://localhost:8080/swagger-ui.html#/" method="GET">
			<input type="submit" value="View Swagger Documentation">
		</form>
	</div>
</body>
</html>