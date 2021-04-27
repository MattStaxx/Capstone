package com.hcl.MusicStore.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.dm.ProductDataManager;
import com.hcl.MusicStore.entities.Product;

@Service
public class RestProductService {
	@Autowired
	private final ProductDataManager productDm;
	
	RestProductService(ProductDataManager productDm) {
		this.productDm = productDm;
	}
	
	public CollectionModel<EntityModel<Product>> getCatalog() {
		List<EntityModel<Product>> catalog = productDm.getCatalog();
		return CollectionModel.of(catalog);
	}
}
