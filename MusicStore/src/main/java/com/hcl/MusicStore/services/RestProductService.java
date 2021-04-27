package com.hcl.MusicStore.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.dm.ProductDataManager;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.models.ProductResponse;
import com.hcl.MusicStore.models.Catalog;
import com.hcl.MusicStore.models.CatalogProduct;
import com.hcl.MusicStore.models.ProductRequest;

@Service
public class RestProductService {
	@Autowired
	private final ProductDataManager productDm;
	
	RestProductService(ProductDataManager productDm) {
		this.productDm = productDm;
	}
	
	public ProductResponse getCatalog() {
		ProductResponse res = new ProductResponse(productDm.getCatalog());
		return res;
	}
	
	public ProductResponse getProduct(ProductRequest req) {
		ProductResponse res = new ProductResponse(productDm.getCatalogProduct(req));
		return res;
	}
	
	public void saveProduct(ProductRequest req) {
		req.setId(null);
		productDm.saveProduct(req);
	}

	public void updateProduct(ProductRequest req) {
		CatalogProduct found = productDm.getCatalogProduct(req);
		if (found == null) {
			productDm.saveProduct(req);
		} else {
			productDm.saveProduct(req);
		}
	}
	
	public void deleteProduct(ProductRequest req) {
		productDm.deleteProduct(req);
	}
}
