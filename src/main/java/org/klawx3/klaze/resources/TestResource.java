package org.klawx3.klaze.resources;


import org.klawx3.klaze.db.model.User;
import org.klawx3.klaze.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


import java.util.List;

@RestController
public class TestResource {

    @Autowired
    private UserService userService;

    @GetMapping(value = "/users")
    public List<User> getListUser(){
        return userService.getAllUsers();
    }

    @GetMapping(value = "/admin")
    public String getPageTest(){
        return "Admin";
    }

    @GetMapping(value = "/test")
    public String getTest(){
        return "Testo";
    }
}
