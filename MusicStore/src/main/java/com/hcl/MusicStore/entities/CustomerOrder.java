package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

@Entity
public class CustomerOrder implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="order_id")
    private Integer id;
    private int orderNumber;
    private enum Status { ORDERED, SHIPPED, DELIVERED }  // maybe include 'PENDING' for orders still in a customers cart?? 
    													 // maybe include 'RETURNED' if an order return capability is need??..just brainstorming...
    
//    @OneToMany(mappedBy="product_id")  // this is producing a "org.hibernate.AnnotationException:"
//    private Set<Product> products;    // 'mappedBy reference an unknown target entity property: com.hcl.MusicStore.entities.Product.product_id in com.hcl.MusicStore.entities.CustomerOrder.products'
    
    
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
	public Set<Product> getProducts() { return products; }
	public List<MusicUser> getCustomer() { return customer; }

	public void setId(Integer id) { this.id = id; }
	public void setOrderNumber(int orderNumber) { this.orderNumber = orderNumber; }
	public void setProducts(Set<Product> products) { this.products = products; }
	public void setCustomer(List<MusicUser> customer) { this.customer = customer; }
	
}
