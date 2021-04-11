package com.hcl.MusicStore.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.repositories.ProductRepository;

@Service
public class ProductService {
	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
    
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
	
	public Optional<Product> searchProductByID(int productID) {
		return productRepository.findById(productID);
	}
	
	
	public Iterable<Product> getAllProducts() {
		return productRepository.findAll();
	}
	
	public List<Product> getAllProductsList() {
		return productRepository.findAll();
	}

	public List<Product> getAllProductsByUser(MusicUser user) {
		return productRepository.findAllByCustomer(user);
	}
	
	public List<Product> getAllProductsByOrder(CustomerOrder order) {
		return productRepository.findAllByCustomerOrder(order);
	}
	
	public List<Product> searchForProducts(String selection, String name) {
		logger.info("In Product Service... " + selection + " " + name);
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


	public List<Product> displayCatalog(){
        List<Product> products = productRepository.findAll();
        List<Product> catalog = new ArrayList<Product>();
        for (Product p : products) {
            if (p.getCustomerOrder() == null && p.getCustomer() == null) {
                catalog.add(p);
            }
        }
        return catalog;
    }   
}
