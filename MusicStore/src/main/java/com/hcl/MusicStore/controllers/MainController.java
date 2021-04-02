package com.hcl.MusicStore.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	// Viewable by All
    @GetMapping("/")
    public String defaultpage() {
        return "home";
    }
    
    @GetMapping("/home")
    public String showHome() {
        return "home";
    }
    
    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }
    
    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }
    
    @GetMapping("/catalog")
    public String showCatalog() {
        return "catalog";
    }
    
    @GetMapping("/about")
    public String showAbout() {
        return "about";
    }
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
    
    // Viewable by Admins
    @GetMapping("/admin")
    public String showAdmin() {
        return "admin";
    }
    
    @GetMapping("/manageinventory")
    public String showInventoryManage() {
    	return "inventorymanage";
    }
    
    @GetMapping("/manageusers")
    public String showUserManage() {
    	return "usermanage";
    }
    
}
