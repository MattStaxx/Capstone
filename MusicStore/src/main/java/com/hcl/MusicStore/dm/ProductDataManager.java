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
import com.hcl.MusicStore.models.Catalog;
import com.hcl.MusicStore.models.CatalogProduct;
import com.hcl.MusicStore.models.ProductRequest;
import com.hcl.MusicStore.models.ProductResponse;
import com.hcl.MusicStore.repositories.ProductRepository;

@Component
public class ProductDataManager implements RepresentationModelAssembler<Product, EntityModel<CatalogProduct>> {
	@Autowired
	private ProductRepository productRepository;
	
	// Wraps Resource (Product) with an EntityModel
	@Override
	public EntityModel<CatalogProduct> toModel(Product product) {
		CatalogProduct catalogProduct = new CatalogProduct();
		catalogProduct.setId(product.getId());
		catalogProduct.setTitle(product.getTitle());
		catalogProduct.setCategory(product.getCategory());
		catalogProduct.setPrice(product.getPrice());
		catalogProduct.setImageurl(product.getImageurl());
		return EntityModel.of(catalogProduct);
	}
	
	// Retrieve data from req and process it into an entity
	public Product requestToProduct(ProductRequest req) {
		Product productEntity = new Product();
		productEntity.setId(req.getId());
		productEntity.setCategory(null);
		productEntity.setImageurl(null);
		productEntity.setTitle(req.getTitle());
		productEntity.setArtist(req.getArtist());
		productEntity.setStyle(req.getStyle());
		productEntity.setPrice(req.getPrice());
		productEntity.setGenre(req.getGenre());
		productEntity.setQuantity(req.getQuantity());
		productEntity.setCustomer(req.getCustomer());
		productEntity.setCustomerOrder(req.getCustomerOrder());
		return productEntity;
	}
	
	public CatalogProduct getCatalogProduct(ProductRequest req) {
		Optional<Product> found = productRepository.findById(req.getId());
		if (found.isEmpty()) {
			return null;
		}
		Product productEntity = found.get();
		return toModel(productEntity).getContent();
	}
	
	// Will be used in the admin view, perhaps use another business object
	public List<EntityModel<CatalogProduct>> getAllProducts() {
		List<EntityModel<CatalogProduct>> products = productRepository.findAll().stream()
				.map(this::toModel)
				.collect(Collectors.toList());
		if (products.isEmpty()) {
			return null;
		}
		return products;
	}
	
	// Converts list of Product Entities to a Catalog Business object
	public Catalog getCatalog() {
		Catalog catalog = new Catalog(productRepository.findAll().stream()
				.filter(p -> p.getCustomer() == null && p.getCustomerOrder() == null)
				.map(this::toModel)
				.collect(Collectors.toList()));
		if (catalog.getProducts().isEmpty()) {
			return null;
		}
		return catalog;
	}
	
	public void saveProduct(ProductRequest req) {
		productRepository.save(requestToProduct(req));
	}
	
	public void deleteProduct(ProductRequest req) {
		productRepository.delete(requestToProduct(req));
	}
}
