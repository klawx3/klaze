package org.klawx3.klaze.resources;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class TestResource {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(Model model){
        String texto = "Hola mundo wea";
        model.addAttribute("texto",texto);
        return "index";
    }
}
