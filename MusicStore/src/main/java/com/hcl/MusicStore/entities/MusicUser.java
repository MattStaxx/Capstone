package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Set;

import javax.persistence.*;

import com.hcl.MusicStore.models.Catalog;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity // This tells Hibernate to make a table out of this class
@Table(name = "user_tbl")
public class MusicUser implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;   
    private String firstname;   
    private String lastname;
    private String username;
    private String email;
    private String password;    
    private String creditcard;    
    private String role; // Either "ADMIN" or "USER"
    
    @OneToMany(mappedBy="customer")
    private Set<CustomerOrder> orders; // This will map to the user's orders in the database
    
    @OneToMany(mappedBy ="id")
    private Set<Product> cart; // This will represent the shopping cart

    public MusicUser() {}
    
    public MusicUser(String firstname, String lastname, String username, String email, String password, String creditcard, String role) {
    	this.firstname = firstname;
    	this.lastname = lastname;
    	this.username = username;
    	this.email = email;
    	this.password = password;
    	this.creditcard = creditcard;
    	this.role = role;
    }
	
	@Override
	public String toString() {
		return "MusicUser: id:" + this.id + "Username: " + this.username;
	}
}