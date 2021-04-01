package com.hcl.MusicStore.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
    @GetMapping("/")
    public String defaultpage() {
        return "index";
    }
    
    @GetMapping("/index")
    public String showIndex() {
        return "index";
    }
    
    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }
    
    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @GetMapping("/home")
    public String showHome() {
        return "home";
    }
    
    @GetMapping("/admin")
    public String showAdmin() {
        return "admin";
    }
    
}
