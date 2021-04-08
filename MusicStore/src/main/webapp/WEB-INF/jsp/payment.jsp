<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

    <title>Payment</title>
  </head>
  <body> 
  <h1 class="display-1">The Music Store</h1>  
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
      <div class="py-5 text-center">
        <h2>Checkout form</h2>
        <p class="lead">Please fill out your payment details below</p>
      </div>

      <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Your cart</span>
            <span class="badge badge-secondary badge-pill">3</span>
          </h4>
          <ul class="list-group mb-3">
          	<c:set var="total" value="${0}"/>
          	<c:forEach items="${products}" var="product">
          		<li class="list-group-item d-flex justify-content-between lh-condensed">
          			<div>
          				<h6 class="my-0">${product.title}</h6>
          				<small class="text-muted">${product.genre}</small>
          			</div>
          			<span class="text-muted">$${product.price} x ${product.quantity} item(s) = $${product.price * product.quantity}</span>
          		</li>
          		
          		<c:set var="total" value="${total + (product.price * product.quantity)}" />
          	</c:forEach>
          	
          	<li class="list-group-item d-flex justify-content-between bg-light">
              <div class="text-success">
                <h6 class="my-0">${discountname}</h6>
                <small>${discountdesc}</small>
              </div>
              <span class="text-success">-${discount}</span>
            </li>
          	
            <li class="list-group-item d-flex justify-content-between">
              <span>Total (USD)</span>
              <strong>$ ${total - discount}</strong>
            </li>
          </ul>

          <form class="card p-2" action="/redeemcoupon" method="post">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Promo code" name="code">
              <div class="input-group-append">
                <button type="submit" class="btn btn-secondary">Redeem</button>
              </div>
            </div>
          </form>
        </div>
        <div class="col-md-8 order-md-1">
          <h4 class="mb-3">Billing address</h4>
          <form class="needs-validation" action="/checkout" method="post" novalidate>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="firstName">First name</label>
                <input type="text" class="form-control" id="firstName" placeholder="" value="${user.firstname}" required>
                <div class="invalid-feedback">
                  Valid first name is required.
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="lastName">Last name</label>
                <input type="text" class="form-control" id="lastName" placeholder="" value="${user.lastname}" required>
                <div class="invalid-feedback">
                  Valid last name is required.
                </div>
              </div>
            </div>

            <div class="mb-3">
              <label for="username">Username</label>
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">@</span>
                </div>
                <input type="text" class="form-control" id="username" placeholder="Username" value="${user.username}" required>
                <div class="invalid-feedback" style="width: 100%;">
                  Your username is required.
                </div>
              </div>
            </div>

            <div class="mb-3">
              <label for="email">Email</label>
              <input type="email" class="form-control" id="email" placeholder="you@example.com" value="${user.email}">
              <div class="invalid-feedback">
                Please enter a valid email address for shipping updates.
              </div>
            </div>

            <div class="mb-3">
              <label for="address">Address</label>
              <input type="text" class="form-control" id="address" placeholder="1234 Main St" required>
              <div class="invalid-feedback">
                Please enter your shipping address.
              </div>
            </div>

            <div class="mb-3">
              <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
              <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
            </div>

            <div class="row">
              <div class="col-md-5 mb-3">
                <label for="country">Country</label>
                <select class="custom-select d-block w-100" id="country" required>
                  <option value="">Choose...</option>
                  <option>United States</option>
                </select>
                <div class="invalid-feedback">
                  Please select a valid country.
                </div>
              </div>
              <div class="col-md-4 mb-3">
                <label for="state">State</label>
                <input class="form-control" type="text" name="state" maxlength="2" placeholder="TX">
                <div class="invalid-feedback">
                  Please provide a valid state.
                </div>
              </div>
              <div class="col-md-3 mb-3">
                <label for="zip">Zip</label>
                <input type="text" class="form-control" id="zip" placeholder="" required>
                <div class="invalid-feedback">
                  Zip code required.
                </div>
              </div>
            </div>
            <hr class="mb-4">
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" id="same-address">
              <label class="custom-control-label" for="same-address">Shipping address is the same as my billing address</label>
            </div>
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" id="save-info">
              <label class="custom-control-label" for="save-info">Save this information for next time</label>
            </div>
            <hr class="mb-4">

            <h4 class="mb-3">Credit Card</h4>
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="cc-name">Name on card</label>
                <input type="text" class="form-control" id="cc-name" placeholder="" required>
                <small class="text-muted">Full name as displayed on card</small>
                <div class="invalid-feedback">
                  Name on card is required
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label for="cc-number">Credit card number</label>
                <input type="text" class="form-control" name=cardnumber id="cc-number" placeholder="" required>
                <div class="invalid-feedback">
                  Credit card number is required
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-3 mb-3">
                <label for="cc-expiration">Expiration</label>
                <input type="text" class="form-control" name=expire id="cc-expiration" placeholder="" required>
                <div class="invalid-feedback">
                  Expiration date required
                </div>
              </div>
              <div class="col-md-3 mb-3">
                <label for="cc-expiration">CVV</label>
                <input type="text" class="form-control" name=cvv id="cc-cvv" placeholder="" required>
                <div class="invalid-feedback">
                  Security code required
                </div>
              </div>
            </div>
            <hr class="mb-4">
            
            <input class="btn btn-secondary btn-lg btn-block" type="submit" value="Complete Payment">
          </form>
        </div>
      </div>

    </div>  
	<!--   
	<h1>Payment</h1>
	<form action="/checkout" method="post">
	<input type="tel" name="cardnumber" pattern="\d*" maxlength="19" placeholder="Card Number">
	<input type="tel" name="expire" pattern="\d*" maxlength="7" placeholder="MM / YY">
    <input type="tel" name="cvc"  pattern="\d*" maxlength="4" placeholder="CVC">
	<input type="submit" value="Complete Payment"></form>
	-->
	</body>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
        	    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" 
        	    crossorigin="anonymous"></script>
</html>