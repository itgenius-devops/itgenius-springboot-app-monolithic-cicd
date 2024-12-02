package products;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import products.entities.User;
import products.repository.UserRepository;
import products.dto.RegistrationForm;

import java.util.Optional;

@SpringBootApplication
public class ItGenuineApplication {

    public static void main(String[] args) {
        // Load environment variables from .env file
        Dotenv dotenv = Dotenv.configure().load();
        
        // Set the loaded environment variables to system properties if needed
        System.setProperty("DB_URL", dotenv.get("DB_URL", "jdbc:mysql://mysql:3306/itgeniusdb"));
        System.setProperty("DB_USERNAME", dotenv.get("DB_USERNAME", "root"));
        System.setProperty("DB_PASSWORD", dotenv.get("DB_PASSWORD", "rootpassword"));
        System.setProperty("SERVER_PORT", dotenv.get("SERVER_PORT", "8085"));
        
        SpringApplication.run(ItGenuineApplication.class, args);
    }

    @Bean
    public CommandLineRunner dataLoader(UserRepository userRepo) {
        return new CommandLineRunner() {
            @Override
            public void run(String... args) {
                PasswordEncoder encoder = new BCryptPasswordEncoder();
                Optional<User> user = userRepo.findByUsername("user");
                if (!user.isPresent()) {
                    RegistrationForm form = new RegistrationForm("info@itgenius.com",
                            "itgenius", "itgenius");
                    userRepo.save(form.toUser(encoder));
                }
            }
        };
    }
}
