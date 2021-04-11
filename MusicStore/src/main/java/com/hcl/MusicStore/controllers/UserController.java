package com.hcl.MusicStore.controllers;

import java.util.List;
import java.security.Principal;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hcl.MusicStore.Exceptions.OrderAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.OrderNotFoundException;
import com.hcl.MusicStore.Exceptions.ProductAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.ProductNotFoundException;
import com.hcl.MusicStore.Exceptions.UserAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.UserNotFoundException;
import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.services.CustomerOrderService;
import com.hcl.MusicStore.services.MusicUserService;
import com.hcl.MusicStore.services.ProductService;

@Controller
public class UserController {
	
	@Autowired
	MusicUserService musUseServ;
	
	@Autowired
	CustomerOrderService custOrdServ;
	
	@Autowired
	ProductService productService;

	Logger log = LoggerFactory.getLogger(UserController.class);
	
	// Viewable by Customers
    
    @GetMapping("/profile")
    public String showProfile(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
    	if(user == null) {
    		throw new UserNotFoundException(username);
    	} else {
    		//
    	}
    	m.addAttribute("user", user);
        return "profile";
    }
    
    @PostMapping("/updateProfile")
    public String editProfile(
			@RequestParam String username, 
			@RequestParam String firstname, 
			@RequestParam String lastname,
			@RequestParam String email,
			@RequestParam String password,
			@RequestParam String creditcard,
			@RequestParam String role,
			Principal principal,
			ModelMap m) {
    	String un = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(un);
    	if(user == null) {
    		throw new UserNotFoundException(un);
    	} else {  }
    	user.setFirstname(firstname);
    	user.setLastname(lastname);
    	user.setEmail(email);
    	user.setPassword(password);
    	user.setCreditcard(creditcard);
    	musUseServ.updateUser(user);
    	Iterable<MusicUser> mu = musUseServ.findUserByFirstname(user.getFirstname());
 		m.addAttribute("successMessage", "Profile Update Successful!");
 		m.addAttribute("userdetails", mu);
 		m.addAttribute("username", username);
		return "profile";
    }
    @GetMapping("/shoppingcart")
    public String showCheckout(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<Product> cart = productService.getAllProductsByUser(user);
			log.info("Cart size... " + cart.size());
			for (Product product : cart) {
				log.info(product.toString());
			}
			m.addAttribute("products", cart);
		}
        return "shoppingcart";
    }
    
    @PostMapping("/checkout")
    public String performCheckout(
    		@RequestParam(required=false, defaultValue="1234") String cardnumber,
    		@RequestParam(required=false, defaultValue="1234") String expire,
    		@RequestParam(required=false, defaultValue="1234") String cvv,
    		Principal principal, 
    		ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			// Set Payment Info
			user.setCreditcard(cardnumber);
			musUseServ.updateUser(user);
			
			// Retrieve Cart
			List<Product> cart = productService.getAllProductsByUser(user);
			log.info("Order size... " + cart.size());
			for (Product product : cart) {
				log.info(product.toString());
			}
			CustomerOrder.Status status = CustomerOrder.Status.ORDERED;
			
			// Create New Order
			CustomerOrder newOrder = new CustomerOrder(status, cart);
			newOrder.setCustomer(user);
	    	custOrdServ.saveOrder(newOrder);
	    	m.addAttribute("order", newOrder);
	    	
	    	// First, check if anything is out of stock
	    	for(Product product : cart) {
	    		// Subtract Catalog Item Quantity
	    		List<Product> catalog = productService.getAllProductsByUser(null);
	    		for (Product catalogProduct : catalog) {
	    			if (catalogProduct.getCustomerOrder() == null && catalogProduct.getTitle().equals(product.getTitle())) {
	    				int difference = catalogProduct.getQuantity() - product.getQuantity();
	    				if (difference < 0) { // If in stock, subtract quantity accordingly
	    					m.addAttribute("errorMessage", "Sorry, " + product.getTitle() + " is out of stock!");
	    					m.addAttribute("products", cart);
	    					m.addAttribute("user", user);
	    					productService.deleteProduct(product.getId());
	    					return "payment";
	    				}
	    			}
	    		}
	    	}
	    	
	    	// Set the new quantities
	    	for(Product product : cart) {
	    		// Subtract Catalog Item Quantity
	    		List<Product> catalog = productService.getAllProductsByUser(null);
	    		for (Product catalogProduct : catalog) {
	    			if (catalogProduct.getCustomerOrder() == null && catalogProduct.getTitle().equals(product.getTitle())) {
	    				int difference = catalogProduct.getQuantity() - product.getQuantity();
	    				if (difference >= 0) { // If in stock, subtract quantity accordingly
	    					catalogProduct.setQuantity(difference);
	    					productService.saveProduct(catalogProduct);
	    				}
	    			}
	    		}
	    	}
	    	
	    	// Clear out the shopping cart
	    	for(Product product : cart) {
	    		Product orderProduct = new Product(
		    		null, 
		    		product.getCategory(),
		    		product.getImageurl(),
		    		product.getTitle(), 
		    		product.getArtist(), 
		    		product.getStyle(), 
		    		product.getFormat(), 
		    		product.getPrice(), 
		    		product.getGenre(), 
		    		product.getQuantity(),
		    		newOrder, 
		    		null);
	    		productService.saveProduct(orderProduct);
	    		productService.deleteProduct(product.getId());
	    		
	    		
	    	}
			log.info("New Order Posted");
		}
    	return "orderconfirm";
    }
    
    @PostMapping("/getOrderDetails") 
    public String getOrderDetails(
    		@RequestParam Integer orderid,
    		Principal principal,
    		ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		CustomerOrder order = custOrdServ.getOrderById(orderid);
		List<Product> products = productService.getAllProductsByOrder(order);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else if (order == null || products == null) {
			throw new OrderNotFoundException(orderid);
		} else {
			order.setProducts(products);
			m.addAttribute("products", products);
			m.addAttribute("user", user);
			m.addAttribute("order", order);
		}
    	return "orderconfirm";
    }
    
    
    @PostMapping("/redeemcoupon") // Gets orders by Username
    public String redeemCoupon(
    		@RequestParam String code,
    		Principal principal, 
    		ModelMap m) {
    	if (code.equals("SAVEEVERYTHING")) {
    		int discount = 999999999;
    		m.addAttribute("discount", discount);
    		m.addAttribute("discountname", "SAVEEVERYTHING");
    		m.addAttribute("discountdesc", "WAIT STOP we're gonna go bankrupt!");
    	}
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<Product> cart = productService.getAllProductsByUser(user);
			m.addAttribute("products", cart);
			m.addAttribute("user",user);
		}
    	return "payment";
    }
    
    @GetMapping("/payment") // Gets orders by Username
    public String showPayment(
    		Principal principal, 
    		ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<Product> cart = productService.getAllProductsByUser(user);
			if(cart.isEmpty()) {
				m.addAttribute("errorMessage","Shopping Cart is empty!");
				return "shoppingcart";
			}
			m.addAttribute("products", cart);
			m.addAttribute("user",user);
		}
    	return "payment";
    }
    
    @GetMapping("/orderhistory") // Gets orders by Username
    public String showHistory(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<CustomerOrder> orders = custOrdServ.getOrdersByUser(user);
			log.info("Order History.. " + orders.size() + " items");
			for (CustomerOrder order : orders ) { 
				List<Product> products = productService.getAllProductsByOrder(order);
				order.setProducts(products);
				log.info("Order #" + order.getId() + " " + products.size() + " item(s)");
			}
			m.addAttribute("username", username);
			m.addAttribute("orders", orders);
		}
        return "orderhistory";                       
    }
    
    @PostMapping("/addToCart")
    public String addToCart(
    	@RequestParam Integer id,
    	@RequestParam Integer quantity,
 		Principal principal,
 		ModelMap m) {
    	
		String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			Optional<Product> foundproduct = productService.searchProductByID(id);
	    	if (foundproduct.isEmpty()) {
	    		throw new ProductNotFoundException(id);
	    	}
	    	
	    	Product product = foundproduct.get();
	    	
	    	// Check if Product is already in the cart
	    	List<Product> cart = productService.getAllProductsByUser(user);
	    	if (!cart.isEmpty()) { // If its the same item increment the quantity
	    		for (Product cartProd : cart) {
	    			if (cartProd.getTitle().equals(product.getTitle())) { 
	    				Integer newQuantity = cartProd.getQuantity() + quantity;
	    				if (newQuantity > product.getQuantity()) {
	    					m.addAttribute("errorMessage", "Invalid quantity!");
	    		    		m.addAttribute("product", product);
	    		    		return "catalog";
	    				} else {
	    					cartProd.setQuantity(newQuantity);
	    					productService.saveProduct(cartProd);
	    					List<Product> products = productService.displayCatalog();
	    					m.addAttribute("Product", products);
	    					m.addAttribute("successMessage", "Product added to cart!");
	    			    	return "catalog";
	    				}
	    			}
	    		}
	    	}
	    	
	    	if (product.getQuantity() < quantity) {
	    		m.addAttribute("errorMessage", "Invalid quantity!");
	    		m.addAttribute("product", product);
	    		return "productdetails";
	    	}
	    	Product cartProduct = new Product(
	    			null, 
	    			product.getCategory(),
	    			product.getImageurl(),
	    			product.getTitle(), 
	    			product.getArtist(), 
	    			product.getStyle(), 
	    			product.getFormat(), 
	    			product.getPrice(), 
	    			product.getGenre(), 
	    			quantity,
	    			null, 
	    			user);
	    	productService.saveProduct(cartProduct);
		}
		List<Product> products = productService.displayCatalog();
		m.addAttribute("Product", products);
		m.addAttribute("successMessage", "Product Added to Cart!");
    	return "catalog";
    }
    
    @PostMapping("/deleteFromCart")
    public String removeFromCart(
        	@RequestParam Integer id,
        	Principal principal,
        	ModelMap m) {
    	productService.deleteProduct(id);
    	m.addAttribute("successMessage", "Item Removed!");
    	// Retrieve Shopping cart again
    	String username = principal.getName();
		MusicUser user = musUseServ.getUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<Product> cart = productService.getAllProductsByUser(user);
			log.info("Cart size... " + cart.size());
			for (Product product : cart) {
				log.info(product.toString());
			}
			m.addAttribute("products", cart);
		}
    	
    	return "shoppingcart";
    }
    
    @GetMapping("/search") // Searches for everything but price returns list to be passed into table
    public String showSearch(ModelMap m, @RequestParam String options, @RequestParam String name){
        log.info("Searching");
        System.out.println("options: "+options);
        Iterable<Product> products=productService.searchForProducts(options,name);
        log.info("Search successful Results:");
        for (Product product : products ) {
        	log.info(product.getTitle());
        }
        m.addAttribute("Product", products);
        return "catalog";
    }
   
    @GetMapping("/searchprice") // Searches for price returns list to be passed into table
    public String showSearchByPrice(ModelMap m, @RequestParam int lowerprice,
            @RequestParam int higherprice){
        log.info("Searching");
        Iterable<Product> products=productService.searchForProductsByPrice(lowerprice,higherprice);
        for (Product product : products ) {
        	log.info(product.getPrice()+"");
        }
        log.info("Search successful");
        m.addAttribute("Product", products);
        return "catalog";
    }
    
    @GetMapping("/details")
    public String showDetails(ModelMap m, @RequestParam int idnumber) {
        log.info("Searching");
        Optional<Product> products= productService.searchProductByID(idnumber);
        Product dproduct=products.get();
        log.info("Search successful");
        m.addAttribute("product", dproduct);
        return "productdetails";
    }
    
    @ExceptionHandler(OrderAlreadyExistsException.class) 
	public ModelAndView handleOrderAlreadyExistsException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Order aleady Exists!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
	
	@ExceptionHandler(OrderNotFoundException.class) 
	public ModelAndView handleOrdeNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Order not Found!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
	
	@ExceptionHandler(ProductAlreadyExistsException.class) 
	public ModelAndView handleProductAlreadyExistsException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Product aleady Exists!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
	
	@ExceptionHandler(ProductNotFoundException.class) 
	public ModelAndView handleProductNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Product not found!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
	
	@ExceptionHandler(UserNotFoundException.class) 
	public ModelAndView handleUserNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Username/Password combination not found!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
	
    @ExceptionHandler(UserAlreadyExistsException.class)
	public ModelAndView handleAlreadyExistException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Account creation failed: User already exists!");
	    modelAndView.setViewName("error");
	    return modelAndView;
	}
}
