<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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


<title>Profile</title>
</head>
<body>
<h1 class="display-1">The Music Store</h1>
<nav class="p-3 bg-dark text-white">
  <div class="container">
    <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
      <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
      </a>

      <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
        <li><a href="home" class="nav-link px-2 text-secondary">Home</a></li>
        <li><a href="catalog" class="nav-link px-2 text-white">Catalog</a></li>
        <li><a href="about" class="nav-link px-2 text-white">About</a></li>
        <sec:authorize access="isAuthenticated()">
        	<li><a class="nav-link px-2 text-white" href="orderhistory">Order History</a></li>
        	<li><a class="nav-link px-2 text-white" href="shoppingcart">Cart</a></li>
    	   	
    	</sec:authorize>
      </ul>
		

			
	  <sec:authorize access="!isAuthenticated()">
      	<div class="text-end">
        	<a class="btn btn-outline-light me-2" href="login"  >Login</a>
    		<a class="btn btn-warning" href="register">Register</a>
      	</div>
      </sec:authorize>
      
      <sec:authorize access="isAuthenticated()">
      	<div class="dropdown text-end">
        <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
          <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
        </a>
        <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1">
        	<sec:authorize access="hasAnyRole('ADMIN')">
    			 <li><a class="dropdown-item" href="admin">Admin</a></li>
    	 		 <li><a class="dropdown-item" href="manageinventory">Manage Inventory</a></li>
    			 <li><a class="dropdown-item" href="manageorders">Manage Orders</a></li>
    			 <li><a class="dropdown-item" href="manageusers">Manage Users</a></li>	
			</sec:authorize>
       	  	<li><a class="dropdown-item" href="profile">Profile</a></li>
       	 	<li><hr class="dropdown-divider"></li>
         	<li><a class="dropdown-item" href="logout">Sign out</a></li>
       	</ul>
     	</div>
      </sec:authorize>
    </div>
  </div>
</nav>  

	<h1 class="display-1">Order Confirmation</h1>
	
	<c:set var="order" value="${order}"/>
	
	<div class="container">
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>Your Order Confirmation</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">Order Number</th>
					<th scope="col">Status</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td><c:out value="${order.id}" /></td>
						<td><c:out value="${order.orderNumber}" /></td>
						<td><c:out value="${order.status}" /></td>
					</tr>
			</tbody>
		</table>
		
		<table class="table table-striped table-bordered" id="tblData">
			<thead>
				<tr><h1>What You Ordered:</h1></tr>
				<tr>		
					<th scope="col">Id</th>
					<th scope="col">Title</th>
					<th scope="col">Category</th>
					<th scope="col">Artist</th>
					<th scope="col">Style</th>
					<th scope="col">Format</th>
					<th scope="col">Price</th>
					<th scope="col">Genre</th>
					<th scope="col">Quantity</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${order.products}" var="product">
					<tr>
						<td><c:out value="${product.id}" /></td>
						<td><c:out value="${product.title}" /></td>
						<td><c:out value="${product.category}" /></td>
						<td><c:out value="${product.artist}" /></td>
						<td><c:out value="${product.style}" /></td>
						<td><c:out value="${product.format}" /></td>
						<td><c:out value="${product.price}" /></td>
						<td><c:out value="${product.genre}" /></td>
						<td><c:out value="${product.quantity}" /></td>
					</tr>
					<c:set var="total" value="${total + (product.price * product.quantity)}" />
				</c:forEach>
			</tbody>
		</table>
		<h1>Your Total: ${total}</h1>
	</div>
	<script src="/javascript/search.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.3.2.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>

	 <footer class="page-footer font-small indigo" id="footer" style="width:100%">
    
                    <!-- Copyright -->
                    <div class="footer-copyright text-center py-3">© 2021 Copyright:
                      <a href="localhost:8080/">The Music tore</a>
                    </div>
                    <!-- Copyright -->
          
                  </footer>
                  <!-- Footer -->
       
      
             	<script>
		var element = document.getElementById("footer");
		var rect = element.getBoundingClientRect();
		var w = window.innerWidth;
		var h = window.innerHeight;
	
		console.log(rect.top,  rect.bottom);
		console.log(w+" "+h);
		if(rect.bottom<=h){element.style="position: fixed; bottom: 0; width:100%";}
		//console.log(x);
		rect = element.getBoundingClientRect();
				console.log(rect.top, rect.bottom);
		console.log(w+" "+h);
		var count=0; 
		window.onresize = reportWindowSize;
		function reportWindowSize(){console.log("hi");
		count++; 		element.style="position:width:100%";
		if(count!=1){
			 rect = element.getBoundingClientRect();
			 h = window.innerHeight;
			 console.log(rect.bottom+" "+h);
			if(rect.bottom<=h){element.style="position: fixed; bottom: 0; width:100%";}
			else{element.style="position:width:100%";}
		}
		}
		</script>
               <style>
  footer {
  text-align: center;
  padding: 3px;
  background-color: black;
  color: white;
}
</style>       

	
	
	
	
	
</body>
</html>