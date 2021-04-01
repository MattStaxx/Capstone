package com.hcl.MusicStore.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    
    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
