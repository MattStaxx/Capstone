package com.hcl.MusicStore.models;

import java.util.List;

import org.springframework.hateoas.EntityModel;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Catalog {
	private List<EntityModel<CatalogProduct>> products;
	
	public Catalog(List<EntityModel<CatalogProduct>> products) {
		this.products = products;
	}
}
