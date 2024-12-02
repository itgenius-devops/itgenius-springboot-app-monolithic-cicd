package products.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {
    @GetMapping
    public String registerForm() {
        return "index";
    }

    @GetMapping("welcome")
    public String welcomePage() {
        return "congratulations";
    }

}
