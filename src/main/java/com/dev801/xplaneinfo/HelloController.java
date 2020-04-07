package com.dev801.xplaneinfo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {

    private static final Logger LOGGER = LoggerFactory.getLogger(HelloController.class);

    @GetMapping("/")
    public String index(Model model) {
        LOGGER.info("Where in main controller.");

        return "hello";
    }

    @GetMapping("/hello")
    public String hello(Model model, @RequestParam(value = "name", required = false, defaultValue = "World") String name) {
        LOGGER.info("here");
        model.addAttribute("name", name);
        return "hello";
    }
}
