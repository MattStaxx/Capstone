package com.hcl.MusicStore.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="User already exists") //404
public class UserAlreadyExistsException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    
    public UserAlreadyExistsException(String username) {
    	super("UserNotFoundException with username="+username);
    }
}
