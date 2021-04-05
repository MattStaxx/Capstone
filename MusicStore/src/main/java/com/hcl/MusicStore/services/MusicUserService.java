package com.hcl.MusicStore.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hcl.MusicStore.entities.MusicUser;
import com.hcl.MusicStore.repositories.MusicUserRepository;



@Service()
@Qualifier("UserService")
public class MusicUserService {
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MusicUserRepository userRepository;
	
	public List<MusicUser> GetAllUsers(){
		List<MusicUser> users = userRepository.findAll();
		return users;
	}
    
    public MusicUser GetUserByUsername(String username) {
    	Optional<MusicUser> foundUser = userRepository.findByUsername(username);
    	if (!foundUser.isPresent()) {
    		return null;
    	}
    	return(foundUser.get());
    }
    
    public MusicUser GetUserByPassword(String password) {
    	Iterable<MusicUser> musicUsers = userRepository.findAll();
    	for (MusicUser musicUser : musicUsers) {
    		if (musicUser.getPassword().equals(password)) {
    			return musicUser;
    		}
    	}
        return null;
    }
    
    public MusicUser GetUserById(int id) {
    	Optional<MusicUser> foundUser = userRepository.findById(id);
    	
    	if (!foundUser.isPresent()) {
    		return null;
    	}
    	
    	return(foundUser.get());
    }
    
    public MusicUser UpdateUser(MusicUser usertoUpdate) {
    	usertoUpdate.setPassword(passwordEncoder.encode(usertoUpdate.getPassword()));
    	return userRepository.save(usertoUpdate);
    }

    public void DeleteUserById(int id) {
    	userRepository.deleteById(id);
    }
}
