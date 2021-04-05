package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.util.HashSet;
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
public class CustomerOrder implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private int orderNumber;
    private enum Status { ORDERED, SHIPPED, DELIVERED }  // maybe include 'PENDING' for orders still in a customers cart?? 
    													 // maybe include 'RETURNED' if an order return capability is need??..just brainstorming...
    
    @ManyToMany(mappedBy="orders", fetch=FetchType.LAZY)
    private Set<Product> products;    
    
    @ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.PERSIST)
    @JoinTable(name="orders_by_customers", 
			    joinColumns={@JoinColumn(name="order_id", referencedColumnName="id", nullable=false, updatable=false)},
			    inverseJoinColumns={@JoinColumn(name="user_id", referencedColumnName="id", nullable=false, updatable=false)})
    private Set<MusicUser> customer;
    
	public CustomerOrder() { super(); }
	
    public CustomerOrder(int orderNumber) {
		super();
		this.orderNumber = orderNumber;
	}

	public Integer getId() { return id; }
	public int getOrderNumber() { return orderNumber; }
	public Set<Product> getProducts() { return products; }
	public Set<MusicUser> getCustomer() { return customer; }

	public void setOrderNumber(int orderNumber) { this.orderNumber = orderNumber; }
	public void setProducts(Set<Product> products) { this.products = products; }
	public void setCustomer(Set<MusicUser> customer) { this.customer = customer; }
	
}
