package com.hcl.MusicStore.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.services.CustomerOrderService;
import com.hcl.MusicStore.services.MusicUserService;

@Controller
public class UserController {
	
	@Autowired
	MusicUserService musUseServ;
	
	@Autowired
	CustomerOrderService custOrdServ;

	Logger log = LoggerFactory.getLogger(UserController.class);
	
	// Viewable by Customers
    @GetMapping("/shoppingcart")
    public String showShoppingCart() {
        return "shoppingcart";
    }
    
    @GetMapping("/profile")
    public String showProfile() {
        return "profile";
    }
    
    @GetMapping("/orderhistory")                                      // this searches for all orders by username
    public String showHistory(ModelMap m, @RequestParam String username) {
    	log.info("showHistory..." + username);
//    	MusicUser customer = musUseServ.GetUserByUsername(username);
    	log.info("finding user's orders..." + username);
    	Iterable<CustomerOrder> orders = custOrdServ.getOrdersByUser(username);
    	log.info("sending orders to view...");
    	m.addAttribute("orderList", orders);
        return "home";                       // hijacked the homepage for now, but this should be a profile view(customer) and an admin capability
    }
}
