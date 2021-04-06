package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.*;

@Entity // This tells Hibernate to make a table out of this class
//@Table(name = "usertable")
public class MusicUser implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="user_id")
    private Integer id;   
    private String firstname;   
    private String lastname;
    private String username;
    private String email;
    private String password;    
    private String creditcard;    
    private String role; // Either "ADMIN" or "USER"
    
    @OneToMany(mappedBy="customer", fetch=FetchType.LAZY)
    private Set<CustomerOrder> orders; // This will map to the user's orders in the database
    
    @ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.PERSIST)
    @JoinTable(name="cart", 
			    joinColumns={@JoinColumn(name="user_id", referencedColumnName="user_id", nullable=false, updatable=false)},
			    inverseJoinColumns={@JoinColumn(name="product_id", referencedColumnName="product_id", nullable=false, updatable=false)})
    private Set<Product> products; // This will represent the shopping cart

    public MusicUser() {}
    
    public MusicUser(String firstname, String lastname, String username, String email, String password, String role) {
    	this.firstname = firstname;
    	this.lastname = lastname;
    	this.username = username;
    	this.email = email;
    	this.password = password;
    	this.role = role;
    }
    
	public Integer getId() { return id; }
	public String getFirstname() { return firstname; }
	public String getLastname() { return lastname; }
	public String getUsername() { return username; }
	public String getEmail() { return email; }
	public String getPassword() { return password; }
	public String getCreditcard() { return creditcard; }
	public String getRole() { return role; }
	public Set<CustomerOrder> getOrders() { return orders; }
	public Set<Product> getProducts() { return products; }

	public void setId(Integer id) { this.id = id; }
	public void setFirstname(String firstname) { this.firstname = firstname; }
	public void setLastname(String lastname) { this.lastname = lastname; }
	public void setUsername(String username) { this.username = username; }
	public void setEmail(String email) { this.email = email; }
	public void setPassword(String password) { this.password = password; }
	public void setCreditcard(String creditcard) { this.creditcard = creditcard; }
	public void setRole(String role) { this.role = role; }
	public void setOrders(Set<CustomerOrder> orders) { this.orders = orders; }
	public void setProducts(Set<Product> products) { this.products = products; }
}