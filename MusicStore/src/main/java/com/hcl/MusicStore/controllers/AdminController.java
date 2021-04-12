package com.hcl.MusicStore.controllers;

import java.math.BigDecimal;
import java.util.ArrayList;
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
    public String showInventoryManage(
    		@RequestParam(required=false, defaultValue="1") Integer page,
			@RequestParam(required=false, defaultValue="10") Integer maxproducts,
			Model m) {
    	
    	List<Product> products = productService.getAllProductsList();
		List<Product> paginatedlist = new ArrayList<Product>();
		Integer totalproducts = products.size();
		Integer totalpages = 0;
		if ( totalproducts % maxproducts == 0) {
			totalpages = totalproducts/maxproducts;
		} else {
			totalpages = totalproducts/maxproducts + 1;
		}
		
		m.addAttribute("totalpages",totalpages);
		m.addAttribute("totalproducts",totalproducts);
		m.addAttribute("page",page);
		m.addAttribute("maxproducts",maxproducts);
		
		if (maxproducts >= totalproducts) { // No need for pagination
			m.addAttribute("products", products);
			return "inventorymanage";
		} else { // Do Pagination
			Integer firstidx = null;
			if (page == null || page <= 1) {
				firstidx = 0;
				for(int i = firstidx; i < maxproducts && i < totalproducts; i++) {
					paginatedlist.add(products.get(i));
				}
			} else {
				firstidx = maxproducts * (page-1);
				for(int i = firstidx; i < firstidx+maxproducts && i < totalproducts; i++) {
					paginatedlist.add(products.get(i));
				}
				
			}
			m.addAttribute("products", paginatedlist);
		}

		for (Product p : paginatedlist) {
			logger.info("Product in Catalog...");
			logger.info(p.toString());
		}
    	m.addAttribute("products", paginatedlist);
    	return "inventorymanage";
    }
    
    @PostMapping("/editOrder")
    public String showOrderEdit(
    		@RequestParam Integer id, 
    		Model model) {
    	CustomerOrder order = customerOrderService.getOrderById(id);
    	if (order == null) {
    		throw new OrderNotFoundException(id);
    	}
    	List<Product> products = productService.getAllProductsByOrder(order);
    	logger.info("Products in the order: " + products.size());
    	model.addAttribute("products", products);
    	model.addAttribute("order", order);
    	return "orderedit";
    }
    
    @GetMapping("/manageorders")
    public String showOrderManage(Model model) {
    	List<CustomerOrder> orders = customerOrderService.getAllOrders();
    	for (CustomerOrder order : orders ) { 
			List<Product> products = productService.getAllProductsByOrder(order);
			order.setProducts(products);
			logger.info("Order #" + order.getId() + " " + products.size() + " item(s)");
		}
    	model.addAttribute("orders", orders);
    	return "ordermanage";
    }
    
    @PostMapping("/addOrder")
    public String addOrder(
     		@RequestParam Integer ordernumber,
     		@RequestParam CustomerOrder.Status status, 
     		@RequestParam String user,
     		Model model){
    	MusicUser foundUser = userService.getUserByUsername(user);
     	CustomerOrder foundOrder = customerOrderService.getOrderByOrderNumber(ordernumber);
     	if (foundOrder != null) {
     		throw new OrderAlreadyExistsException(ordernumber);
     	} else if (foundUser == null) {
     		throw new UserNotFoundException(user);
     	} else {
     		CustomerOrder newOrder = new CustomerOrder(status, null);
     		newOrder.setCustomer(foundUser);
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
    		// Delete products associated with the order
    		List<Product> orderProducts = productService.getAllProductsByOrder(foundOrder);
    		for (Product p : orderProducts) {
    			productService.deleteProduct(p.getId());
    		}
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
    
    @PostMapping("/updateOrderStatus")
    public String updateOrder(
     		@RequestParam Integer id,
     		@RequestParam CustomerOrder.Status status, 
     		Model model){
     	CustomerOrder foundOrder = customerOrderService.getOrderById(id);
     	if (foundOrder == null) {
     		throw new OrderNotFoundException(id);
     	} else {
     		foundOrder.setStatus(status);
     		customerOrderService.saveOrder(foundOrder);
     		logger.debug("Order Status Updated: " + foundOrder);
     		model.addAttribute("successMessage", "Order Update Successful!");
     		model.addAttribute("orders", customerOrderService.getAllOrders());
     	}
     	return "ordermanage";
    }
    
 	@PostMapping("/addProduct")
    public String addProduct(
    		@RequestParam(required=false) Integer orderid,
    		@RequestParam(required=false) String category,
    		@RequestParam(required=false) String imageurl,
     		@RequestParam String title,
     		@RequestParam(required=false) String artist, 
     		@RequestParam(required=false) String style, 
     		@RequestParam String format, 
     		@RequestParam BigDecimal price, 
     		@RequestParam(required=false) String genre,
     		@RequestParam Integer quantity,
     		Model model){
 		Product newProduct = null;
     	Optional<Product> foundProduct = productService.searchProductByTitle(title);
     	if (orderid != null ) { // New Product In Order
     		CustomerOrder foundOrder = customerOrderService.getOrderById(orderid);
     		if (foundOrder == null) {
         		throw new OrderNotFoundException(orderid);
     		} else {
     			
     			newProduct = new Product(null, category, imageurl, title, artist, style, format, price, genre, quantity, foundOrder, null);
     			productService.saveProduct(newProduct);
     			List<Product> products = productService.getAllProductsByOrder(foundOrder);
     			model.addAttribute("products", products);
     	    	model.addAttribute("order", foundOrder);
     	    	model.addAttribute("successMessage", "Product added to Order!");
     		}
     	} else { // New Product In Catalog
     		if (foundProduct.isPresent()) {
         		throw new ProductAlreadyExistsException(title);
         	} else {
         		newProduct = new Product(null, category, imageurl, title, artist, style, format, price, genre, quantity, null, null);	
         		productService.saveProduct(newProduct);
         		model.addAttribute("products", productService.getAllProducts());
         		model.addAttribute("successMessage", "Product Creation Successful!");
         	}     	
     	}
 		logger.info("New Product Added: " + newProduct);
 		if (orderid != null) {
 			return "orderedit";
 		}
 		return "inventorymanage";
    }
 	
 	@PostMapping("/deleteProduct")
    public String deleteProduct(
    		@RequestParam(required=false) Integer orderid,
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
 		if (orderid != null) {
 			CustomerOrder foundOrder = customerOrderService.getOrderById(orderid);
     		if (foundOrder == null) {
         		throw new OrderNotFoundException(orderid);
     		} else {
     			List<Product> products = productService.getAllProductsByOrder(foundOrder);
     			model.addAttribute("products", products);
     	    	model.addAttribute("order", foundOrder);
     	    	return "orderedit";
     		}
 		}
 		return "inventorymanage";
 		
    }
 	
 	@PostMapping("/updateProduct")
    public String updateProduct(
    		@RequestParam(required=false) Integer orderid,
    		@RequestParam(required=false) String category,
    		@RequestParam(required=false) String imageurl,
    		@RequestParam Integer id,
     		@RequestParam String title,
     		@RequestParam(required=false) String artist, 
     		@RequestParam(required=false) String style, 
     		@RequestParam String format, 
     		@RequestParam BigDecimal price , 
     		@RequestParam(required=false) String genre,
     		@RequestParam Integer quantity,
     		Model model){
     	Optional<Product> foundProduct = productService.searchProductByID(id);
     	Product newProduct = null;
     	if (!foundProduct.isPresent()) {
     		throw new ProductNotFoundException(title);
     	} 
     	if (orderid != null ) { // New Product In Order
     		CustomerOrder foundOrder = customerOrderService.getOrderById(orderid);
     		if (foundOrder == null) {
         		throw new OrderNotFoundException(orderid);
     		} else {	
     			newProduct = new Product(id, category, imageurl, title, artist, style, format, price, genre, quantity, foundOrder, null);
     			productService.saveProduct(newProduct);
     			List<Product> products = productService.getAllProductsByOrder(foundOrder);
     			model.addAttribute("products", products);
     	    	model.addAttribute("order", foundOrder);
     	    	model.addAttribute("successMessage", "Product Updated");
     	    	return "orderedit";
     		}
     	} else {
     		newProduct = new Product(id, category, imageurl, title, artist, style, format, price, genre, quantity, null, null);
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
    	MusicUser foundUser = userService.getUserByUsername(username);
    	if (foundUser != null) {
    		throw new UserAlreadyExistsException(username);
    	} else {
    		MusicUser newUser = new MusicUser(firstname, lastname, username, email, password, null, role);
    		userService.updateUser(newUser);
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
    		// Delete all orders/products associated with the user
    		List<Product> cart = productService.getAllProductsByUser(foundUser);
    		List<CustomerOrder> orders = customerOrderService.getOrdersByUser(foundUser);
    		for (CustomerOrder o : orders) {
    			customerOrderService.deleteOrderById(o.getId());
    		}
    		for (Product p : cart) {
    			productService.deleteProduct(p.getId());
    		}
    		userService.deleteUserById(id);
    		logger.debug("User Account with ID: " + id + " deleted.");
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
    		@RequestParam(required=false) String role, 
    		Model model){
		if (role == null) {
			model.addAttribute("errorMessage", "Please specify a role!");
			return "usermanage";
		}
    	MusicUser foundUser = userService.GetUserById(id);
    	if (foundUser == null) {
    		throw new UserNotFoundException(id);
    	} else {
    		MusicUser newUser = new MusicUser(firstname, lastname, username, email, password, null, role);
    		newUser.setId(id);
    		userService.updateUser(foundUser);
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
	    modelAndView.setViewName("inventorymanage");
	    return modelAndView;
	}
	
	@ExceptionHandler(ProductNotFoundException.class) 
	public ModelAndView handleProductNotFoundException(HttpServletRequest request, Exception ex){
		ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("errorMessage", "Product not found!");
	    modelAndView.addObject("products", productService.getAllProducts());
	    modelAndView.setViewName("inventorymanage");
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
