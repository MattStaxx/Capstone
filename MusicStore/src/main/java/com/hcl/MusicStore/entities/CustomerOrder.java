package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;


//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.FetchType;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.JoinTable;
//import javax.persistence.ManyToMany;
//import javax.persistence.OneToMany;

import javax.persistence.*;

import com.hcl.MusicStore.models.Catalog;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "order_tbl")
public class CustomerOrder implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private int orderNumber;
    public enum Status { ORDERED (0), SHIPPED(1), DELIVERED(2); 
    	private int status;
    	
    	private Status(int status) {
    		this.status = status;
    	}
    }  // maybe include 'PENDING' for orders still in a customers cart?? 
     // maybe include 'RETURNED' if an order return capability is need??..just brainstorming...
    
    private Status status;
    
    @OneToMany(mappedBy="id")
    private List<Product> products;    
    
    @ManyToOne
    @JoinColumn(name="customer_id")
    private MusicUser customer;
    
	public CustomerOrder() { super(); }
	
    public CustomerOrder(int orderNumber) {
		super();
		this.orderNumber = orderNumber;
	}
    
    public CustomerOrder(Status status, List<Product> products) {
		super();
		this.status = status;
		this.products = products;
	}
	
	@Override
	public String toString() {
		return "CustomerOrder: id:" + this.id;
	}
}