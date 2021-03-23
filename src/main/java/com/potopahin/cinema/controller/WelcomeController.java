package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class WelcomeController {

    @Autowired
    private SessionService sessionService;

    @GetMapping("/welcome")
    public String showForm(Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("sessions", sessionService.getSessions());
        return "welcome";
    }

    @PostMapping("/welcome")
    public String goToSession(Model model) {
        return "sessionPage/";
    }
}
