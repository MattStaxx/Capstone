package com.hcl.MusicStore.controllers;

import java.util.ArrayList;
import java.util.List;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hcl.MusicStore.Exceptions.ProductNotFoundException;
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
		MusicUser user = musUseServ.GetUserByUsername(username);
    	if(user == null) {
    		throw new UserNotFoundException(username);
    	} else {
    		//
    	}
    	Iterable<MusicUser> ud = musUseServ.findUserByFirstname(user.getFirstname());
    	m.addAttribute("username", username);
    	m.addAttribute("userdetails", ud);
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
		MusicUser user = musUseServ.GetUserByUsername(un);
    	if(user == null) {
    		throw new UserNotFoundException(un);
    	} else {  }
    	user.setFirstname(firstname);
    	user.setLastname(lastname);
    	user.setEmail(email);
    	user.setPassword(password);
    	user.setCreditcard(creditcard);
    	musUseServ.UpdateUser(user);
    	Iterable<MusicUser> mu = musUseServ.findUserByFirstname(user.getFirstname());
 		m.addAttribute("successMessage", "Profile Update Successful!");
 		m.addAttribute("userdetails", mu);
 		m.addAttribute("username", username);
		return "profile";
    }
    @GetMapping("/shoppingcart")
    public String showCheckout(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.GetUserByUsername(username);
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
    public String performCheckout(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.GetUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<Product> cart = productService.getAllProductsByUser(user);
			log.info("Order size... " + cart.size());
			for (Product product : cart) {
				log.info(product.toString());
			}
			CustomerOrder.Status status = CustomerOrder.Status.ORDERED;
			CustomerOrder newOrder = new CustomerOrder(CustomerOrder.Status.ORDERED, cart);
			newOrder.setCustomer(user);
	    	custOrdServ.saveOrder(newOrder);
	    	m.addAttribute("order", newOrder);
	    	
	    	// Clear out the shopping cart
	    	for(Product product : cart) {
	    		productService.deleteProduct(product.getId());
	    	}
			log.info("New Order Posted");
		}
    	// TODO need to do payment
    	return "orderconfirm";
    }
    
    @GetMapping("/orderhistory")                                      // this searches for all orders by username
    public String showHistory(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.GetUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			List<CustomerOrder> orders = custOrdServ.getOrdersByUser(user);
			log.info("Order History.. " + orders.size() + " items");
			m.addAttribute("orders", orders);
		}
        return "orderhistory";                       // hijacked the homepage for now, but this should be a profile view(customer) and an admin capability
    }
    
    @PostMapping("/addToCart")
    public String addToCart(
    	@RequestParam Integer id,
    	@RequestParam Integer quantity,
 		Principal principal,
 		ModelMap m) {
    	
		String username = principal.getName();
		MusicUser user = musUseServ.GetUserByUsername(username);
		if (user == null) {
			throw new UserNotFoundException(username);
		} else {
			Optional<Product> foundproduct = productService.searchProductByID(id);
	    	if (foundproduct.isEmpty()) {
	    		throw new ProductNotFoundException(id);
	    	}
	    	Product product = foundproduct.get();
	    	Product cartProduct = new Product(
	    			null, 
	    			product.getTitle(), 
	    			product.getArtist(), 
	    			product.getStyle(), 
	    			product.getFormat(), 
	    			product.getPrice(), 
	    			product.getGenre(), 
	    			quantity,
	    			null, 
	    			null);
	    	cartProduct.setCustomer(user);
	    	productService.saveProduct(cartProduct);
		}
    	return "catalog";
    }
    
    @GetMapping("/search") // Searches for everything but price returns list to be passed into table
    public String showSearch(ModelMap m, @RequestParam String options, @RequestParam String name){
        log.info("Searching");
        Iterable<Product> products=productService.searchForProducts(options,name);
        log.info("Search successful Results:");
        for (Product product : products ) {
        	log.info(product.getTitle());
        }
        m.addAttribute("products", products);
        return "catalog";
    }
   
    @GetMapping("/searchprice") // Searches for price returns list to be passed into table
    public String showSearchByPrice(ModelMap m, @RequestParam int lowerprice,
            @RequestParam int higherprice){
        log.info("Searching");
        Iterable<Product> products=productService.searchForProductsByPrice(lowerprice,higherprice);
        
        log.info("Search successful");
        m.addAttribute("products", products);
        return "catalog";
    }
    @GetMapping("/details")
    public String showDetails(ModelMap m, @RequestParam int idnumber) {
        log.info("Searching");
        Optional<Product> products= productService.searchProductByID(idnumber);
        Product dproduct=products.get();
        List <Product> dprod = new ArrayList<Product>();
        dprod.add(dproduct);
        log.info("Search successful");
        m.addAttribute("products", dprod);
        return "productdetails";
    }
}
