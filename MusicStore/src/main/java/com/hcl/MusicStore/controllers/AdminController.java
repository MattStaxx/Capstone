package com.hcl.MusicStore.controllers;

import java.util.List;
import java.util.Optional;

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

import com.hcl.MusicStore.Exceptions.OrderAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.OrderNotFoundException;
import com.hcl.MusicStore.Exceptions.ProductAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.ProductNotFoundException;
import com.hcl.MusicStore.Exceptions.UserAlreadyExistsException;
import com.hcl.MusicStore.Exceptions.UserNotFoundException;
import com.hcl.MusicStore.entities.CustomerOrder;
import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.entities.Product;
import com.hcl.MusicStore.services.CustomerOrderService;
import com.hcl.MusicStore.services.MusicUserService;
import com.hcl.MusicStore.services.ProductService;

@Controller
public class AdminController { 
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private final MusicUserService userService;
	
	@Autowired
	private final ProductService productService;
	
	@Autowired
	private final CustomerOrderService customerOrderService;
	
	public AdminController(MusicUserService userService, ProductService productService, CustomerOrderService customerOrderService) {
		this.userService = userService;
		this.productService = productService;
		this.customerOrderService = customerOrderService;
	}
	
	// Viewable by Admins
    @GetMapping("/manageusers")
    public String getUsers(ModelMap model) {
        model.addAttribute("users",userService.GetAllUsers());
        return "usermanage";
    }
    
    @GetMapping("/admin")
    public String showAdmin() {
        return "admin";
    }
    
    @GetMapping("/manageinventory")
    public String showInventoryManage(Model model) {
    	model.addAttribute("products", productService.getAllProducts());
    	return "inventorymanage";
    }
    
    @GetMapping("/manageorders")
    public String showOrderManage(Model model) {
    	model.addAttribute("orders", customerOrderService.getAllOrders());
    	return "ordermanage";
    }
    
    @PostMapping("/addOrder")
    public String addOrder(
     		@RequestParam Integer ordernumber,
     		@RequestParam CustomerOrder.Status status, 
     		@RequestParam String products, 
     		@RequestParam String user,
     		Model model){
     	CustomerOrder foundOrder = customerOrderService.getOrderByOrderNumber(ordernumber);
     	if (foundOrder != null) {
     		throw new OrderAlreadyExistsException(ordernumber);
     	} else {
     		CustomerOrder newOrder = new CustomerOrder(ordernumber);
     		newOrder.setStatus(status);
     		customerOrderService.saveOrder(newOrder);
     		logger.debug("New Order Added: " + newOrder);
     		model.addAttribute("successMessage", "Order Creation Successful!");
     		model.addAttribute("orders", customerOrderService.getAllOrders());
     	}
     	return "ordermanage";
    }
    
    @PostMapping("/deleteOrder")
    public String deleteOrder(
    		@RequestParam Integer id,
    		Model model){
 		CustomerOrder foundOrder = customerOrderService.getOrderById(id);
    	if (foundOrder == null) {
    		throw new OrderNotFoundException(id);
    	} else {
    		customerOrderService.deleteOrderById(id);
    		logger.debug("Order with id: " + id + " deleted.");
    		model.addAttribute("successMessage", "Delete Successful");
    		model.addAttribute("orders", customerOrderService.getAllOrders());
    	}
    	return "ordermanage";
    }
    
    @PostMapping("/updateOrder")
    public String updateOrder(
     		@RequestParam Integer ordernumber,
     		@RequestParam CustomerOrder.Status status, 
     		@RequestParam String products, 
     		@RequestParam String user,
     		Model model){
     	CustomerOrder foundOrder = customerOrderService.getOrderByOrderNumber(ordernumber);
     	if (foundOrder == null) {
     		throw new OrderNotFoundException(ordernumber);
     	} else {
     		CustomerOrder newOrder = new CustomerOrder(ordernumber);
     		newOrder.setStatus(status);
     		customerOrderService.saveOrder(newOrder);
     		logger.debug("Order Updated: " + newOrder);
     		model.addAttribute("successMessage", "Order Update Successful!");
     		model.addAttribute("orders", customerOrderService.getAllOrders());
     	}
     	return "ordermanage";
    }
    
 	@PostMapping("/addProduct")
    public String addProduct(
     		@RequestParam String title,
     		@RequestParam(required=false) String artist, 
     		@RequestParam(required=false) String style, 
     		@RequestParam String format, 
     		@RequestParam Double price , 
     		@RequestParam(required=false) String genre,
     		@RequestParam Integer quantity,
     		Model model){
     	Optional<Product> foundProduct = productService.searchProductByTitle(title);
     	if (foundProduct.isPresent()) {
     		throw new ProductAlreadyExistsException(title);
     	} else {
     		Product newProduct = new Product(null, title, artist, style, format, price, genre, quantity, null, null);
     		productService.saveProduct(newProduct);
     		logger.info("New Product Added: " + newProduct);
     		model.addAttribute("successMessage", "Product Creation Successful!");
     		model.addAttribute("products", productService.getAllProducts());
     	}
     	return "inventorymanage";
    }
 	
 	@PostMapping("/deleteProduct")
    public String deleteProduct(
    		@RequestParam Integer id,
    		Model model){
 		Optional<Product> foundProduct = productService.searchProductByID(id);
    	if (!foundProduct.isPresent()) {
    		throw new ProductNotFoundException(id);
    	} else {
    		productService.deleteProduct(id);
    		logger.debug("Product with ID: " + id + " deleted.");
    		model.addAttribute("successMessage", "Delete Successful");
    		model.addAttribute("products", productService.getAllProducts());
    	}
    	return "inventorymanage";
    }
 	
 	@PostMapping("/updateProduct")
    public String updateProduct(
    		@RequestParam Integer id,
     		@RequestParam String title,
     		@RequestParam(required=false) String artist, 
     		@RequestParam(required=false) String style, 
     		@RequestParam String format, 
     		@RequestParam Double price , 
     		@RequestParam(required=false) String genre,
     		@RequestParam Integer quantity,
     		Model model){
     	Optional<Product> foundProduct = productService.searchProductByTitle(title);
     	if (!foundProduct.isPresent()) {
     		throw new ProductNotFoundException(title);
     	} else {
     		Product newProduct = new Product(id, title, artist, style, format, price, genre, quantity, null, null);
     		productService.saveProduct(newProduct);
     		logger.info("Product Updated: " + newProduct);
     		model.addAttribute("successMessage", "Product Update Successful!");
     		model.addAttribute("products", productService.getAllProducts());
     	}
     	return "inventorymanage";
    }
 	
	// The register mapping that sends initial credentials to the database
	@PostMapping("/addUser")
    public String addUser(
    		@RequestParam String firstname,
    		@RequestParam String lastname, 
    		@RequestParam String username, 
    		@RequestParam String password, 
    		@RequestParam String email, 
    		@RequestParam String role, 
    		Model model){
    	MusicUser foundUser = userService.GetUserByUsername(username);
    	if (foundUser != null) {
    		throw new UserAlreadyExistsException(username);
    	} else {
    		MusicUser newUser = new MusicUser(firstname, lastname, username, email, password, null, role);
    		userService.UpdateUser(newUser);
    		logger.info("New User Registered: " + newUser);
    		model.addAttribute("successMessage", "Registration Successful!");
    		model.addAttribute("users", userService.GetAllUsers());
    	}
    	return "usermanage";
    }
	
	@PostMapping("/deleteUser")
    public String addUser(
    		@RequestParam Integer id,
    		Model model){
    	MusicUser foundUser = userService.GetUserById(id);
    	if (foundUser == null) {
    		throw new UserNotFoundException(id);
    	} else {
    		userService.DeleteUserById(id);
    		logger.debug("User with ID: " + id + " deleted.");
    		model.addAttribute("successMessage", "Delete Successful");
    		model.addAttribute("users", userService.GetAllUsers());
    	}
    	return "usermanage";
    }
	
	@PostMapping("/updateUser")
    public String addUser(
    		@RequestParam Integer id,
    		@RequestParam String firstname,
    		@RequestParam String lastname, 
    		@RequestParam String username, 
    		@RequestParam String password, 
    		@RequestParam String email, 
    		@RequestParam String role, 
    		Model model){
    	MusicUser foundUser = userService.GetUserById(id);
    	if (foundUser == null) {
    		throw new UserNotFoundException(id);
    	} else {
    		MusicUser newUser = new MusicUser(firstname, lastname, username, email, password, null, role);
    		newUser.setId(id);
    		userService.UpdateUser(foundUser);
    		logger.debug("User Updated: " + foundUser);
    		model.addAttribute("successMessage", "Update Successful!");
    		model.addAttribute("users", userService.GetAllUsers());
    	}
    	return "usermanage";
    }
	
	@ExceptionHandler(OrderAlreadyExistsException.class) 
	public ModelAndView handleOrderAlreadyExistsException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Order aleady Exists!");
	    modelAndView.addObject("orders", customerOrderService.getAllOrders());
	    modelAndView.setViewName("ordermanage");
	    return modelAndView;
	}
	
	@ExceptionHandler(OrderNotFoundException.class) 
	public ModelAndView handleOrdeNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Order not Found!");
	    modelAndView.addObject("orders", customerOrderService.getAllOrders());
	    modelAndView.setViewName("ordermanage");
	    return modelAndView;
	}
	
	@ExceptionHandler(ProductAlreadyExistsException.class) 
	public ModelAndView handleProductAlreadyExistsException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Product aleady Exists!");
	    modelAndView.addObject("products", productService.getAllProducts());
	    modelAndView.setViewName("usermanage");
	    return modelAndView;
	}
	
	@ExceptionHandler(ProductNotFoundException.class) 
	public ModelAndView handleProductNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Product not found!");
	    modelAndView.addObject("products", productService.getAllProducts());
	    modelAndView.setViewName("usermanage");
	    return modelAndView;
	}
	
	@ExceptionHandler(UserNotFoundException.class) 
	public ModelAndView handleUserNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Username/Password combination not found!");
	    modelAndView.addObject("users", userService.GetAllUsers());
	    modelAndView.setViewName("usermanage");
	    return modelAndView;
	}
	
    @ExceptionHandler(UserAlreadyExistsException.class)
	public ModelAndView handleAlreadyExistException(HttpServletRequest request, Exception ex){
		logger.error("Requested URL="+request.getRequestURL());
		logger.error("Exception Raised="+ex);
		
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Account creation failed: User already exists!");
	    modelAndView.addObject("users", userService.GetAllUsers());
	    modelAndView.setViewName("usermanage");
	    return modelAndView;
	}
}
