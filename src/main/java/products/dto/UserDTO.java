package products.dto;
import lombok.*;

@Data
//Our own customization of userdetails with more fields to register
public class UserDTO{
    private String username;
    private String fullname;
    private Long id;
}