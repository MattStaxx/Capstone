package com.hcl.MusicStore.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "usertable")
public class MusicUser {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "user_id")
    private Integer id;   
    private String firstname;   
    private String lastname;
    private String username;
    private String email;
    private String password;    
    private String creditcard;    
    private String role; // Either "ADMIN" or "USER"
    
    @ManyToMany
    private List<CustomerOrder> orders; // This will map to the user's orders in the database
    
    @ManyToMany
    private List<Product> products; // This will represent the shopping cart

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
	public List<CustomerOrder> getOrders() { return orders; }
	public List<Product> getProducts() { return products; }

	public void setId(Integer id) { this.id = id; }
	public void setFirstname(String firstname) { this.firstname = firstname; }
	public void setLastname(String lastname) { this.lastname = lastname; }
	public void setUsername(String username) { this.username = username; }
	public void setEmail(String email) { this.email = email; }
	public void setPassword(String password) { this.password = password; }
	public void setCreditcard(String creditcard) { this.creditcard = creditcard; }
	public void setRole(String role) { this.role = role; }
	public void setOrders(List<CustomerOrder> orders) { this.orders = orders; }
	public void setProducts(List<Product> products) { this.products = products; }
}