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
}
