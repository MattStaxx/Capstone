package com.hcl.MusicStore.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.hcl.MusicStore.entities.Product;

public interface ProductRepository extends JpaRepository <Product, Integer> {
	public Optional<Product> findByTitle(String username);
}
