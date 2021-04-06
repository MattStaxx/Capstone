package com.hcl.MusicStore.configurations;

import javax.annotation.Resource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.hcl.MusicStore.services.MusicUserDetailsService;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	@Resource
	   private MusicUserDetailsService userDetailsService;
	
	@Override
	protected void configure(final HttpSecurity http) throws Exception {
	    http
	      .csrf().disable()
	      .authorizeRequests()
	      .antMatchers( // Endpoints that ANYONE can access
	    		  	"/",
	      			"/home*",
	      			"/register*",
	      			"/login",
	      			"/css/**",
	      			"/loginError",
	      			"/catalog",
	      			"/about*",
	      			"/swagger-ui.html",
	      			"/webjars/springfox-swagger-ui/css/**")
	      			.permitAll()
	      .antMatchers("/profile", "/orderhistory","/search","/searchprice", "/details", "/shoppingcart", "/addToCart").authenticated() //Endpoints that all logged in users can access
	      .antMatchers("/*").hasRole("ADMIN") // Endpoints that admins can access (All of them)
	      .and()
	      .formLogin()
	      	.loginPage("/login")
	      	.loginProcessingUrl("/performLogin")
	      	.defaultSuccessUrl("/home", true)
	      	.failureUrl("/loginError")
	      	.and()
	      .logout()
	      	.permitAll();
	}
	
	@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
    @Bean
    public DaoAuthenticationProvider authProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

   	
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authProvider());
    }
    
}