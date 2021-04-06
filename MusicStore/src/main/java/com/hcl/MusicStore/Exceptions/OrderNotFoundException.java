package com.hcl.MusicStore.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="Product Not Found") //404
public class OrderNotFoundException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public OrderNotFoundException(int orderId) {
    	super("OderNotFoundException: Order #" + orderId + " could not be located");
    }
}
