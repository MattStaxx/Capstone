package com.hcl.MusicStore.controllers;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hcl.MusicStore.Exceptions.UserAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.UserNotFoundException;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.services.MusicUserService;

@Controller
public class LoginRegistrationController {
	private static final Logger logger = LoggerFactory.getLogger(LoginRegistrationController.class);
	
	@Autowired
	private final MusicUserService userService;
	
	LoginRegistrationController(MusicUserService userService) {
		this.userService = userService;
	}
	
	// The register mapping that sends initial credentials to the database
	@PostMapping("/register")
    public String submitRegister(
    		@RequestParam String firstname,
    		@RequestParam String lastname, 
    		@RequestParam String username, 
    		@RequestParam String password, 
    		@RequestParam String email, 
    		Model model){
    	MusicUser foundUser = userService.GetUserByUsername(username);
    	if (foundUser != null) {
    		throw new UserAlreadyExistsException(username);
    	} else {
    		MusicUser newUser = new MusicUser(firstname, lastname, username, email, password, "USER");
    		userService.UpdateUser(newUser);
    		logger.info("New User Registered: " + newUser);
    		model.addAttribute("successMessage", "Registration Successful!");
    	}
    	return "index";
    }
    
    @ExceptionHandler(UserAlreadyExistsException.class)
	public ModelAndView handleAlreadyExistException(HttpServletRequest request, Exception ex){
		logger.error("Requested URL="+request.getRequestURL());
		logger.error("Exception Raised="+ex);
		
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Register Failed: User already exists!");
	    modelAndView.setViewName("register");
	    return modelAndView;
	}
	
	@GetMapping("/loginError")
    public void showLoginError(ModelMap map) {
		logger.error("Failed login attempt");
		throw new UserNotFoundException();
    }
	
	@ExceptionHandler(UserNotFoundException.class) 
	public ModelAndView handleUserNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Username/Password combination not found!");
	    modelAndView.setViewName("login");
	    return modelAndView;
	}
    
}
