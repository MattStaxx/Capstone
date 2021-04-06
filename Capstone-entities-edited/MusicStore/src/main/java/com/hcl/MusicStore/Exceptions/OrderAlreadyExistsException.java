package com.hcl.MusicStore.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="Order Already Exists") //404
public class OrderAlreadyExistsException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public OrderAlreadyExistsException(int orderId) {
    	super("OrderAlreadyExistsException: Order #" + orderId + " Already Found");
    }
}
