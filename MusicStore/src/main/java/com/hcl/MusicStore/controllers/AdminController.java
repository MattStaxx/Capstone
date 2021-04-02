package com.hcl.MusicStore.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.services.MusicUserService;

@Controller
public class AdminController { 
	@Autowired
	private final MusicUserService userService;
	
	public AdminController(MusicUserService userService) {
		this.userService = userService;
	}
	
	// Viewable by Admins
    @GetMapping("/manageusers")
    public String getUsers(ModelMap model) {
        model.addAttribute("users",userService.GetAllUsers());
        return "usermanage";
    }
    
    @GetMapping("/admin")
    public String showAdmin() {
        return "admin";
    }
    
    @GetMapping("/manageinventory")
    public String showInventoryManage() {
    	return "inventorymanage";
    }
}
