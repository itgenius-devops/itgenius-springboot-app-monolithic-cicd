package products.web;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import products.repository.UserRepository;
import products.dto.RegistrationForm;
import products.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class RegistrationController {

    private final UserRepository userRepo;
    private final PasswordEncoder passwordEncoder;
    private final UserService userService;


    //Pass the registration into another class in order to encode the password BEFORE saving in DB
    @PostMapping
    public String processRegistration(RegistrationForm form) {
        userRepo.save(form.toUser(passwordEncoder));
        return "redirect:/login";
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        if (userService.validateUser(username, password)) {
            session.setAttribute("user", username);
            return ResponseEntity.ok("Login successful");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    @GetMapping("/check-session")
    public ResponseEntity<Boolean> checkSession(HttpSession session, Authentication authentication) {
        return ResponseEntity.ok(session.getAttribute("user") != null);
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout(HttpServletRequest request) {
        new SecurityContextLogoutHandler().logout(request, null, null);
        return ResponseEntity.ok("Logged out successfully");
    }


    @PostMapping("/registration")
    public ResponseEntity<String> registration(@RequestParam String username, @RequestParam String password, @RequestParam String fullName) {
        Boolean isRegistered = userService.registration(username, password, fullName);
        if (!isRegistered){
            return ResponseEntity.status(HttpStatus.ALREADY_REPORTED).body("User already exist");
        }
        return ResponseEntity.ok("Registration completed");
    }

}
