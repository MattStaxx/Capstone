package com.hcl.MusicStore.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.entities.MusicUser;

public interface ProductRepository extends JpaRepository <Product, Integer> {
	public Optional<Product> findByTitle(String username);
	
	public List<Product> findAllByCustomer(MusicUser user);
}
