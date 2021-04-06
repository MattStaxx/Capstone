package com.hcl.MusicStore.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.Exceptions.OrderNotFoundException;
import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.repositories.CustomerOrderRepository;
import com.hcl.MusicStore.repositories.MusicUserRepository;

@Service
public class CustomerOrderService {

	@Autowired
	private CustomerOrderRepository orderRepository;

	@Autowired
	private MusicUserRepository userRepository;
	
	public void saveOrder(CustomerOrder order) {
		orderRepository.save(order);
	}
	
	public void deleteOrderById(Integer id) {
		orderRepository.deleteById(id);
	}
	
	public void deleteOrderByOrderNumber(Integer ordnum) {
		orderRepository.deleteByOrderNumber(ordnum);
	}
	
	public List<CustomerOrder> getAllOrders() {
		List<CustomerOrder> orders = orderRepository.findAll();
		return orders;
	}
	
	public CustomerOrder getOrderById(int id) {
		Optional<CustomerOrder> order = orderRepository.findById(id);
    	if (!order.isPresent()) {
    		return null;
    	}
    	return(order.get());
	}
	
	public CustomerOrder getOrderByOrderNumber(int ordNum) {
		Optional<CustomerOrder> order = orderRepository.findByOrderNumber(ordNum);
    	if (!order.isPresent()) {
    		throw new OrderNotFoundException(ordNum);
    	}
    	return(order.get());
	}
	
	public List<CustomerOrder> getOrdersByUser(MusicUser user) {
		return orderRepository.findAllByCustomer(user);
	}

	public Iterable<CustomerOrder> getOrdersByUser(String username) {

    	Optional<MusicUser> customer = userRepository.findByUsername(username);
		return orderRepository.findAllOrdersByCustomer(customer);
	}
	
}
