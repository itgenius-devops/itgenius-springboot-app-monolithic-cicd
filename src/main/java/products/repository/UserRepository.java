package products.repository;

import org.springframework.data.repository.CrudRepository;
import products.entities.User;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    Optional<User> findByUsername(String username);

}
