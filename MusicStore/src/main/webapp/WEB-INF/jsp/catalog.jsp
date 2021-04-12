<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">


<title>Catalog</title>
</head>
<body>
	<h1 class="display-1">The Music Store</h1>
	<nav class="p-3 bg-dark text-white">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
				<a href="/"
					class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
					<svg class="bi me-2" width="40" height="32">
						<use xlink:href="#bootstrap" /></svg>
				</a>

				<ul
					class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<li><a href="home" class="nav-link px-2 text-white">Home</a></li>
					<li><a href="catalog" class="nav-link px-2 text-secondary">Catalog</a></li>
					<li><a href="about" class="nav-link px-2 text-white">About</a></li>
					<sec:authorize access="isAuthenticated()">
						<li><a class="nav-link px-2 text-white" href="orderhistory">Order
								History</a></li>
						<li><a class="nav-link px-2 text-white" href="shoppingcart">Cart</a></li>

					</sec:authorize>
				</ul>
				
				<sec:authorize access="!isAuthenticated()">
					<div class="text-end">
						<a class="btn btn-outline-light me-2" href="login">Login</a> <a
							class="btn btn-warning" href="register">Register</a>
					</div>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<div class="dropdown text-end">
						<a href="#"
							class="d-block link-dark text-decoration-none dropdown-toggle"
							id="dropdownUser1" data-bs-toggle="dropdown"
							aria-expanded="false"> <img src="images/coolpanda1_crop.jpg"
							alt="mdo" width="32" height="32" class="rounded-circle">
						</a>
						<ul class="dropdown-menu text-small"
							aria-labelledby="dropdownUser1">
							<sec:authorize access="hasAnyRole('ADMIN')">
								<li><a class="dropdown-item" href="admin">Admin</a></li>
								<li><a class="dropdown-item" href="manageinventory">Manage
										Inventory</a></li>
								<li><a class="dropdown-item" href="manageorders">Manage
										Orders</a></li>
								<li><a class="dropdown-item" href="manageusers">Manage
										Users</a></li>
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
	<div class="container pt-3" align="right">
		<div class="productlist">
			<nav class="text-white">
				<div class="container">
					<div
						class="d-flex flex-wrap align-items-center justify-content-right justify-content-lg-start">
						<a href="/"
							class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
							<svg class="bi me-2" width="40" height="32">
								<use xlink:href="#bootstrap" /></svg>
						</a>

						<!--  https://blog.hubspot.com/website/center-div-css#:~:text=To%20center%20a%20div%20horizontally%20on%20a%20page%2C%20simply%20set,equally%20between%20the%20two%20margins.-->

						<div id="divId1" align=right
							style="position: absolute; left: 50%; transform: translate(-50%, 0); // border: 5px solid #FFFF00; padding: 10px;">
							<!-- Search for everything but Price-->
							<h6 class="text-success">${successMessage}</h6>
							<h6 class="text-danger">${errorMessage}</h6>
							<form action="search" id="search1">
						
						<div class="row">
									<div class="col-2">
										<label for="options"><h4 class="fs-6">Search By:</h4></label>
									</div>
									<div class="col-4">
										<select class="form-select" id="options1" name="options">
											<option value="artist">Artist Name</option>
											<option value="format">Music Format</option>
											<option value="genre">Genre</option>
											<option value="style">Style</option>
											<option value="title">Title</option>
											<option value="category">Category</option>
											<option value="price">Price</option>
										</select>

									</div>
									<div class="col-4">
										<input class="form-control" type="text" id="name" name="name"
											required>
									</div>
									<div class="col-2">
										<input class="form-control fs-8" type="submit" value="Search">
									</div>
								</div>
							</form>

							<form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3"
								action="searchprice" id="search2">
								<div class="row">
									<div class="col">
										<label for="options"> Search By: </label>
									</div>
									<div class="col">
										<select class="form-select" id="options2" name="options">
											<option value="artist">Artist Name</option>
											<option value="format">Music Format</option>
											<option value="genre">Genre</option>
											<option value="style">Style</option>
											<option value="title">Title</option>
											<option value="category">Category</option>
											<option value="price">Price</option>
										</select>
									</div>
									<div class="col">
										<input class="form-control" type="number" id="lowerprice"
											name="lowerprice" placeholder="min" required>
									</div>
									<div class="col">
										<input class="form-control" type="number" id="higherprice"
											name="higherprice" placeholder="max" required>
									</div>
									<div class="col">
										<input class="form-control" type="submit" value="Search">
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>
			</nav>
			<table class="table table-hover" id="tabletosort">
				<thead>
					<tr>
						<th onclick="sortTable(0)" scope="col" > <div style="color:blue;">Title</div></th>
						<th onclick="sortTable(1)" scope="col"><div style="color:blue;">Genre</div></th>
						<th onclick="sortTable(2)" scope="col"><div style="color:blue;">Price</div></th>
						<th onclick="sortTable(3)" scope="col"><div style="color:blue;">Category</div></th>
						<th scope="col"></th>
						<th scope="col"></th>
						<th scope="col"></th>
					</tr>
				</thead>
					
				<script>
				
				
				function findGetParameter(parameterName) {
				    var result = null,
				        tmp = [];
				    var items = location.search.substr(1).split("&");
				    for (var index = 0; index < items.length; index++) {
				        tmp = items[index].split("=");
				        if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
				    }
				    return result;
				}
				var options=findGetParameter("options");
				var lowerPrice=findGetParameter("lowerprice");
				var higherPrice=findGetParameter("higherprice");
				var name=findGetParameter("name");
				var sortBy=findGetParameter("sortBy");;
				var page=findGetParameter("page");
				var maxProduct=findGetParameter("maxproducts");
				var direction=findGetParameter("direction");
				if(direction!=1 && direction!=2){direction=1;}
				if(page==null){page=1;} console.log("page is: "+page);
				if(maxProduct==null){
					maxProduct=localStorage.getItem("maxProduct"); 
					console.log("max product is: "+maxProduct);
				 if(maxProduct==null || maxProduct.length==0){localStorage.setItem("maxProduct", 10); maxProduct=10; console.log("stored"); }	
				}
				else{localStorage.setItem("maxProduct", maxProduct);}
				console.log("zz: "+options+"/"+lowerPrice+"/"+higherPrice+"/"+name+"/"+sortBy+"/"+page+"/"+direction+"/"+maxProduct);
				
			//http://localhost:8080/search2?options=null&lowerprice=null&higherprice=null&name=null&sortBy=null&page=4&direction=1&maxproducts=10
			//http://localhost:8080/search2?options=null&lowerprice=null&higherprice=null&name=null&sortBy=null&page=5&direction=1&maxproducts=10
			//http://localhost:8080/search2?options=null&lowerprice=null&higherprice=null&name=null&sortBy=title&page=1&direction=1&maxproducts=10	
				function sortTable(input){
					console.log("zzzzzzzzz");
				if(input==0){if(sortBy=="title" && direction=="1"){direction=2;}else {direction=1;}; sortBy="title";}
				else if(input==1){if(sortBy=="genre" && direction==1){direction=2;}else {direction=1;}; sortBy="genre";}
				else if(input==2){if(sortBy=="price" && direction==1){direction=2;}else {direction=1;} sortBy="price";}
				else if(input==3){if(sortBy=="category" && direction==1){direction=2;}else {direction=1;} sortBy="category";}
				var redirectUrl="search2?options="+options+"&lowerprice="+lowerPrice+"&higherprice="+higherPrice+"&name="+name+"&sortBy="+sortBy+"&page="+page+"&direction="+direction+"&maxproducts="+maxProduct;
				console.log(redirectUrl);
				window.location.replace(redirectUrl);
				
				
				}
				
				function zz(input){page=input; 	
				if(sortBy==null){sortBy="id"; console.log("sort by id");} else{console.log("error");} 
				var redirectUrl="search2?options="+options+"&lowerprice="+lowerPrice+"&higherprice="+higherPrice+"&name="+name+"&sortBy="+sortBy+"&page="+page+"&direction="+direction+"&maxproducts="+maxProduct;
				console.log(redirectUrl);
				window.location.replace(redirectUrl);}
				</script>
				<tbody>
					<c:forEach items="${Product}" var="product">
						<tr class="zoom">
							<td><a href="/details?idnumber=${product.id}"> ${product.title}</a></td>
							<td><img src="${product.imageurl}" alt="${product.title}"
								alt="mdo" width="100" height="80"
								class="img-thumbnail rounded-square"></td>
							<td>$ ${product.price}</td>
							<td class="col-2">${product.category}</td>
							<td class="row-2">
								<form class="col" action="details">
									<input type="hidden" id="idnumber" name="idnumber"
										value="${product.id}"> <input
										class="btn btn-outline-secondary" type="submit"
										value="Details">
								</form>
							</td>
							<td class="row-2">
								<form class="col" action="/addToCart" method="post">
									<input type="hidden" id="idnumber" name="id"
										value="${product.id}">
									<h6>Quantity</h6>
									<input class="w-25" type="number" id="quantity" name="quantity"
										value="1" required> <input
										class="btn btn-outline-success" type="submit"
										value="Add to Cart">
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>



			<nav>
				<ul class="pagination">
					<c:forEach var="i" begin="1" end="${totalpages}">
						<li class="page-item"><a class="page-link"onclick="zz('${i}')"
								href="#">${i}</a></li>
					</c:forEach>
				</ul>
			</nav>

			
			<form method="get">
				<h6>Products per page</h6>
				<select class="form-select w-25" name="maxproducts" id="options10">
					<option value="${maxproducts}" disabled selected></option>
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="25">25</option>
					<option value="50">50</option>
					<option value="100">100</option>
						<script>
			var option1Z = document.getElementById("options10");
			option1Z.addEventListener("change", function() {
				maxProduct=this.value;
				console.log(maxProduct);
		
			});
			
			function zzz(){
				page=1;
				var redirectUrl="search2?options="+options+"&lowerprice="+lowerPrice+"&higherprice="+higherPrice+"&name="+name+"&sortBy="+sortBy+"&page="+page+"&direction="+direction+"&maxproducts="+maxProduct;
				console.log(redirectUrl);
				window.location.replace(redirectUrl);
				}
			
	</script>
				</select> <input class="btn btn-secondary" type="button" onclick="zzz()" value="Go">
			</form>
			
		
		</div>
	</div>

	<footer class="page-footer font-small indigo" id="footer"
		style="width: 100%">
		<!-- Copyright -->
		<div class="footer-copyright text-center py-3">
			Copyright © 2021 Designed by <span> <a href="/about">The
					Coolest Team!</a> All rights reserved.
			</span> <a href="/catalog">Back to top</a>
			<button class="btn btn-toggle" style="color: red" onclick="myFunction()">Dark/Light</button>
		</div>
	</footer>

	<script src="/javascript/dark.js"></script>
	<script src="/javascript/search.js"></script>
	<script src="/javascript/footer.js"></script>
</body>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
	crossorigin="anonymous"></script>
</html>
