package com.hcl.MusicStore.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

@Entity
public class CustomerOrder {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="order_id")
    private Integer id;
    private int orderNumber;
    private enum Status { ORDERED, SHIPPED, DELIVERED }  // maybe include 'PENDING' for orders still in a customers cart?? 
    													 // maybe include 'RETURNED' if an order return capability is need??..just brainstorming...
    
    @OneToMany(mappedBy="product_id")
    private List<Product> products;
    
    @ManyToMany
    private List<MusicUser> customer;
    
    
	public CustomerOrder() { super(); }
	
    public CustomerOrder(Integer id, int orderNumber) {
		super();
		this.id = id;
		this.orderNumber = orderNumber;
	}

	public Integer getId() { return id; }
	public int getOrderNumber() { return orderNumber; }
	public List<Product> getProducts() { return products; }
	public List<MusicUser> getCustomer() { return customer; }

	public void setId(Integer id) { this.id = id; }
	public void setOrderNumber(int orderNumber) { this.orderNumber = orderNumber; }
	public void setProducts(List<Product> products) { this.products = products; }
	public void setCustomer(List<MusicUser> customer) { this.customer = customer; }
	
}
