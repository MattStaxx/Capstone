package com.hcl.MusicStore.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;

@Repository
public interface CustomerOrderRepository extends JpaRepository<CustomerOrder, Integer> {
	
	public Optional<CustomerOrder> findByOrderNumber(Integer ordNum);
	public Iterable<CustomerOrder> findAllOrdersByCustomer(Optional<MusicUser> customer);
	public List<CustomerOrder> findAllByCustomer(MusicUser user);
	public void deleteByOrderNumber (Integer ordNum);
}
