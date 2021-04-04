package com.hcl.MusicStore.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="Product Not Found") //404
public class ProductNotFoundException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public ProductNotFoundException(String productName) {
    	super("ProductNotFoundException: " + productName + "not available");
    }
}
