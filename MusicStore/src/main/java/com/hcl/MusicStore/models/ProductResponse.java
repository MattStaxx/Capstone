package com.hcl.MusicStore.models;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductResponse {
	private CatalogProduct product;
    private Catalog catalog;
    
    public ProductResponse() {}
    
    public ProductResponse (CatalogProduct product) {
    	this.product = product;
    }
    
    public ProductResponse (Catalog catalog) {
    	this.catalog = catalog;
    }
}
