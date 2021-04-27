package com.hcl.MusicStore.dm;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.RepresentationModelAssembler;
import org.springframework.stereotype.Component;

import com.hcl.MusicStore.controllers.CatalogController;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.repositories.ProductRepository;

@Component
public class ProductDataManager implements RepresentationModelAssembler<Product, EntityModel<Product>> {
	@Autowired
	private ProductRepository productRepository;
	
	@Override
	public EntityModel<Product> toModel(Product product) {
		return EntityModel.of(product);
	}
	
	public EntityModel<Product> getProduct(Integer id) {
		Optional<Product> found = productRepository.findById(id);
		if (found.isEmpty()) {
			return null;
		}
		return EntityModel.of(found.get());
	}
	
	public List<EntityModel<Product>> getAllProducts() {
		List<EntityModel<Product>> products = productRepository.findAll().stream()
				.map(this::toModel)
				.collect(Collectors.toList());
		if (products.isEmpty()) {
			return null;
		}
		return products;
	}
	
	public List<EntityModel<Product>> getCatalog() {
		List<EntityModel<Product>> products = productRepository.findAll().stream()
				.filter(p -> p.getCustomer() == null && p.getCustomerOrder() == null)
				.map(this::toModel)
				.collect(Collectors.toList());
		if (products.isEmpty()) {
			return null;
		}
		return products;
	}
}
