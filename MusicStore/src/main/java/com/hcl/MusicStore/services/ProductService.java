package com.hcl.MusicStore.services;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.repositories.ProductRepository;

@Service
public class ProductService {
    
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired 
	private EntityManager em;
	
	
	public void saveProduct(Product product) {
    	productRepository.save(product);
    }
	
	public void deleteProduct(int productId) {
		productRepository.deleteById(productId);
	}
	
	public Optional <Product> searchProductByTitle(String title){
		return productRepository.findByTitle(title);
	}
	
	public Optional <Product> searchProductByID(int productID) {
		return productRepository.findById(productID);
	}
	
	public Iterable<Product> getAllProducts() {
		return productRepository.findAll();
	}
	
	public List<Product> searchForProducts(String selection, String name) {
		CriteriaBuilder finding= em.getCriteriaBuilder();
		CriteriaQuery<Product>  result= finding.createQuery(Product.class);
		
	    Root<Product> searchSet= result.from(Product.class);
		Predicate searchPredicate= finding.equal(searchSet.get(selection), name);
		result.where(searchPredicate);
		
		TypedQuery<Product> query = em.createQuery(result);
		return query.getResultList();
	}
	
	public List<Product> searchForProductsByPrice(int lowPrice, int highPrice){
		CriteriaBuilder finding= em.getCriteriaBuilder();
		CriteriaQuery<Product>  result= finding.createQuery(Product.class);
		
	    Root<Product> searchSet= result.from(Product.class);
		result.select(searchSet).where(finding.between(searchSet.get("price"),lowPrice,highPrice));
		
		TypedQuery<Product> query = em.createQuery(result);
		return query.getResultList();
	}
}
