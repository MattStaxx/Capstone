package com.hcl.MusicStore.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	// Viewable by Customers
    @GetMapping("/shoppingcart")
    public String showShoppingCart() {
        return "shoppingcart";
    }
    
    @GetMapping("/profile")
    public String showProfile() {
        return "profile";
    }
    
    @GetMapping("/orderhistory")
    public String showHistory() {
        return "orderhistory";
    }
}
