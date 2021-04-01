package com.hcl.MusicStore.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="User Not Found") //404
public class UserNotFoundException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public UserNotFoundException() {
    	super("UserNotFoundException: Invalid Credentials!");
    }
    
    public UserNotFoundException(String username) {
    	super("UserNotFoundException with username="+username);
    }
}
