package com.hcl.MusicStore.models;

import java.math.BigDecimal;

import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CatalogProduct {
	private Integer id;
	private String category;
    private String imageurl;
    private String title;
    private BigDecimal price;
    private Catalog catalog;
}
