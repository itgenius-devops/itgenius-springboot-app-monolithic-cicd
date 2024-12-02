package products.security;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import products.entities.User;
import products.repository.UserRepository;

import java.util.Optional;

@Slf4j
@Service
//Our own implementation of how the users are loaded
public class UserRepositoryUserDetailsService implements UserDetailsService {

    //We use our own repo to check if the user exists
    private UserRepository userRepo;

    @Autowired
    public UserRepositoryUserDetailsService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userRepo.findByUsername(username);
        if (user.isPresent()) {
            log.info("Found user --> " + username );
            return user.get();
        }
        log.error("User " + username + " not found.. Try again!");
        throw new UsernameNotFoundException("User '" + username + "' not found");
    }
}
