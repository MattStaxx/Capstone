package com.hcl.MusicStore.controllers;

import java.util.ArrayList;
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
			@RequestParam(required=false, defaultValue="1") Integer page,
			@RequestParam(required=false, defaultValue="10") Integer maxproducts,
			ModelMap m) {
		List<Product> products = productService.displayCatalog();
		List<Product> catalog = new ArrayList<Product>();
		Integer totalproducts = products.size();
		Integer totalpages = (totalproducts / maxproducts);
		
		m.addAttribute("totalpages",totalpages);
		m.addAttribute("totalproducts",totalproducts);
		m.addAttribute("page",page);
		m.addAttribute("maxproducts",maxproducts);
		
		if (maxproducts >= totalproducts) { // No need for pagination
			m.addAttribute("Product", products);
			return "catalog";
		} else { // Do Pagination
			Integer firstidx = null;
			if (page == null || page <= 1) {
				firstidx = 0;
				for(int i = firstidx; i < maxproducts && i < totalproducts; i++) {
					catalog.add(products.get(i));
				}
			} else {
				firstidx = maxproducts * (page-1);
				for(int i = firstidx; i < firstidx+maxproducts && i < totalproducts; i++) {
					catalog.add(products.get(i));
				}
				
			}
			m.addAttribute("Product", catalog);
		}

		for (Product p : catalog) {
			logger.info("Product in Catalog...");
			logger.info(p.toString());
		}
		
		return "catalog";
	}

	@GetMapping("/about")
	public String showAbout() {
		return "about";
	}
}
