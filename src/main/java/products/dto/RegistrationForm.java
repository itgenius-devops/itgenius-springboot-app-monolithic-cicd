package products.dto;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import lombok.Data;
import products.entities.User;

@Data
@AllArgsConstructor
public class RegistrationForm {

    private String username;
    private String password;
    private String fullname;

    //Creates a new User with the password encoded
    public User toUser(PasswordEncoder passwordEncoder) {
        return new User(null, username, passwordEncoder.encode(password),
                        fullname);
    }

}
