package com.hcl.MusicStore.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hcl.MusicStore.dm.ProductDataManager;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.models.ProductResponse;
import com.hcl.MusicStore.models.ProductRequest;
import com.hcl.MusicStore.services.RestProductService;

@RestController
public class CatalogController {
	@Autowired
	private final RestProductService productService;
	
	CatalogController(RestProductService productService) {
		this.productService = productService;
	}
	
	// Create a product req and response 
	// Create business model of catalog
	@GetMapping("/catalog")
	public ProductResponse all() {
		return productService.getCatalog();
	}
	
	@GetMapping("/getproduct")
	public ProductResponse one(@RequestBody ProductRequest req) {
		return productService.getProduct(req);
	}
	
	@PostMapping("/createproduct")
	public void createProduct(@RequestBody ProductRequest req) {
		productService.saveProduct(req);
	}
	
	@PutMapping("/updateproduct")
	public void updateProduct(@RequestBody ProductRequest req) {
		productService.updateProduct(req);
	}
	
	@DeleteMapping("/deleteproduct")
	public void deleteProduct(@RequestBody ProductRequest req) {
		productService.deleteProduct(req);
	}
}
