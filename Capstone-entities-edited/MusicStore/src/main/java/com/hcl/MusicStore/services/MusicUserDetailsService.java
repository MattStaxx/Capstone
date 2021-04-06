package com.hcl.MusicStore.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.repositories.MusicUserRepository;

@Service
public class MusicUserDetailsService implements UserDetailsService {

    @Autowired
    private MusicUserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) {
        Optional<MusicUser> user = userRepository.findByUsername(username);
        if (!user.isPresent()) {
            throw new UsernameNotFoundException(username);
        } else {
        	MusicUser founduser = user.get();
        	UserDetails details = User
        			.withUsername(founduser.getUsername())
        			.password(founduser.getPassword())
        			.authorities(founduser.getRole())
        			.roles(founduser.getRole())
        			.build();
        	return details;   	
        }
    }
}