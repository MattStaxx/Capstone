package com.hcl.MusicStore.entities;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "product_tbl")
public class Product implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private String artist;
    private String style;
    private String format;
    private double price;
    private String genre;
    private enum Rating { ONE, TWO, THREE, FOUR, FIVE } // Was thinking we'd want a star rating sys??
    private int quantity; 

    @ManyToOne
    @JoinColumn(name="order_id") // Order that this product is associated with
    private CustomerOrder customerOrder;
    
    @ManyToOne
    @JoinColumn(name="cart_id") // User ID of the cart that this product is associated with
    private MusicUser customer;
    
    public Product() {}
    
    public Product(Integer id, String title, String artist, String style, String format, double price, String genre, int quantity, CustomerOrder order, MusicUser customer) {
		super();
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.style = style;
		this.format = format;
		this.price = price;
		this.genre = genre;
		this.quantity = quantity;
		this.customer = customer;
	}

	public Integer getId() { return this.id; }
	public String getTitle() { return this.title; }
	public String getArtist() { return this.artist; }
	public String getStyle() { return this.style; }
	public String getFormat() { return this.format; }
	public double getPrice() { return this.price; }
	public String getGenre() { return this.genre; }
	public int getQuantity() { return this.quantity; }
	public CustomerOrder getCustomerOrder( ) {return this.customerOrder; }
	public MusicUser getCustomer() {return this.customer; }

	public void setTitle(String title) { this.title = title; }
	public void setArtist(String artist) { this.artist = artist; }
	public void setStyle(String style) { this.style = style; }
	public void setFormat(String format) { this.format = format; }
	public void setPrice(double price) { this.price = price; }
	public void setGenre(String genre) { this.genre = genre; }
	public void setQuantity(int quantity) { this.quantity = quantity; }
	public void setCustomerOrder(CustomerOrder order) { this.customerOrder = order; }
	public void setCustomer(MusicUser customer) {this.customer = customer; }
}
