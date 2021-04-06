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
    @GetMapping("/shoppingcart")
    public String showShoppingCart() {
        return "shoppingcart";
    }
    
    @GetMapping("/profile")
    public String showProfile(Principal principal, ModelMap m) {
    	String username = principal.getName();
		MusicUser user = musUseServ.GetUserByUsername(username);
    	if(user == null) {
    		throw new UserNotFoundException(username);
    	} else {
    		//
    	}
    	Iterable<MusicUser> ud = musUseServ.findUserByUser(user.getFirstname());
//    	m.addAttribute("firstname", user.getFirstname());
//    	m.addAttribute("lastname", user.getLastname());
//    	m.addAttribute("email", user.getEmail());
//    	m.addAttribute("password", user.getPassword());
//    	m.addAttribute("creditcard", user.getCreditcard());
//    	m.addAttribute("role", user.getRole());
    	m.addAttribute("username", username);
    	m.addAttribute("userdetails", ud);
        return "profile";
    }
    
    @GetMapping("/orderhistory")                                      // this searches for all orders by username
    public String showHistory(ModelMap m) {
        return "orderhistory";                       // hijacked the homepage for now, but this should be a profile view(customer) and an admin capability
    }
    
    @PostMapping("/addToCart")
    public String addToCart(
    		@RequestParam String title,
     		@RequestParam(required=false) String artist, 
     		@RequestParam(required=false) String style, 
     		@RequestParam String format, 
     		@RequestParam Double price , 
     		@RequestParam(required=false) String genre,
     		@RequestParam Integer quantity, 
     		Principal principal,
     		ModelMap m) {
    		String username = principal.getName();
    		MusicUser user = musUseServ.GetUserByUsername(username);
    		if (user == null) {
    			throw new UserNotFoundException(username);
    		} else {
    			// 
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
