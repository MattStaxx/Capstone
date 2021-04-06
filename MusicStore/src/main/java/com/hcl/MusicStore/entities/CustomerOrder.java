package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    
    @OneToMany(mappedBy="id", fetch=FetchType.LAZY)
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

	public Integer getId() { return id; }
	public int getOrderNumber() { return orderNumber; }
	public Status getStatus() {return status;}
	public List<Product> getProducts() { return products; }
	public MusicUser getCustomer() { return customer; }

	public void setOrderNumber(int orderNumber) { this.orderNumber = orderNumber; }
	public void setProducts(List<Product> products) { this.products = products; }
	public void setCustomer(MusicUser customer) { this.customer = customer; }
	public void setStatus(Status status) {
		this.status = status;
	}
	
}