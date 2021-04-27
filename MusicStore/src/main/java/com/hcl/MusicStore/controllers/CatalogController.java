package com.hcl.MusicStore.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hcl.MusicStore.dm.ProductDataManager;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.services.RestProductService;

@RestController
public class CatalogController {
	@Autowired
	private final RestProductService productService;
	
	CatalogController(RestProductService productService) {
		this.productService = productService;
	}
	
	@GetMapping("/getproducts")
	public CollectionModel<EntityModel<Product>> all() {
		return productService.getCatalog();
	}
}
