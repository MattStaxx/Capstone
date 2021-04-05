package com.hcl.MusicStore.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hcl.MusicStore.entities.Product;

public interface ProductRepository extends JpaRepository <Product, Integer> {

}
