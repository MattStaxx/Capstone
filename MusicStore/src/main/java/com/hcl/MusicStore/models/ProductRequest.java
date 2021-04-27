package com.hcl.MusicStore.models;

import java.math.BigDecimal;

import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductRequest { // Maybe put Catalog Product Here?
	private Integer id;
    private String category;
    private String imageurl;
    private String title;
    private String artist;
    private String style;
    private String format;
    private BigDecimal price;
    private String genre;
    private int quantity;
    private MusicUser customer;
    private CustomerOrder customerOrder;
}
