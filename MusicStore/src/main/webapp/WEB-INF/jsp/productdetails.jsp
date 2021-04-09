<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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



<title>Product Details</title>
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
	<div class="container">

		<div style="color: #0000FF;">${successMessage}</div>
		<div style="color: #FF0000;">${errorMessage}</div>
		<table>

			<tr>
				<td ><figure class="figure">
						<img src="${product.imageurl}"
							class="figure-img img-fluid rounded"
							alt="A generic square placeholder image with rounded corners in a figure.">
						<figcaption class="figure-caption"></figcaption>
					</figure></td>
				<td>
				  <ul style="list-style-type:none;">
				   <li> Artist: ${product.artist}</li>
				   <li> Genre: ${product.genre}</li>
				   <li> Format: ${product.format}</li>
				   <li> Style: ${product.style}</li>
				   <li> Category: ${product.category}</li>
				   <li> In Stock: ${product.quantity}</li>
				   <li> Price: $ ${product.price}</li> <br>
				   <li>
			
					<form action="/addToCart" method="post">
						<input type="hidden" id="idnumber" name="id" value="${product.id}">
						<h6>Quantity</h6><input class="form-control" type="number" id="quantity" name="quantity"
							value="1" required> <input type="submit" class="btn btn-secondary"
							value="Add to Cart">
					</form>
					<li>
					</ul> 
				</td>
			</tr>

		</table>

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