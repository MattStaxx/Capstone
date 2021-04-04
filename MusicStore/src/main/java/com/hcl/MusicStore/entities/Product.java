package com.hcl.MusicStore.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Product implements Serializable {
	
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer product_id;
    private String title;
    private String artist;
    private String style;
    private String format;
    private double price;
    private String genre;
    private enum Rating { ONE, TWO, THREE, FOUR, FIVE } // Was thinking we'd want a star rating sys??
    private int quantity; 

    @ManyToOne
    @JoinColumn(name="order_id", nullable=false)
    private CustomerOrder ordered;
    
    public Product() {}
    
    public Product(Integer id, String title, String artist, String style, String format, double price, String genre, int quantity) {
		super();
		this.product_id = id;
		this.title = title;
		this.artist = artist;
		this.style = style;
		this.format = format;
		this.price = price;
		this.genre = genre;
		this.quantity = quantity;
	}

	public Integer getId() { return this.product_id; }
	public String getTitle() { return this.title; }
	public String getArtist() { return this.artist; }
	public String getStyle() { return this.style; }
	public String getFormat() { return this.format; }
	public double getPrice() { return this.price; }
	public String getGenre() { return this.genre; }
	public int getQuantity() { return this.quantity; }

	public void setTitle(String title) { this.title = title; }
	public void setArtist(String artist) { this.artist = artist; }
	public void setStyle(String style) { this.style = style; }
	public void setFormat(String format) { this.format = format; }
	public void setPrice(double price) { this.price = price; }
	public void setGenre(String genre) { this.genre = genre; }
	public void setQuantity(int quantity) { this.quantity = quantity; }
	
}
