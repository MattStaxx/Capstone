package com.hcl.MusicStore.controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.services.ProductService;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	ProductService productService;

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
	public String showCatalog(
			@RequestParam(required=false) Integer page,
			ModelMap m) {
		List<Product> products = productService.displayCatalog();
		for (Product p : products) {
			logger.info("Product in Catalog...");
			logger.info(p.toString());
		}
		m.addAttribute("Product", products);
		return "catalog";
	}

	@GetMapping("/about")
	public String showAbout() {
		return "about";
	}
}
