package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.form.RegisterForm;
import com.potopahin.cinema.service.UserService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RegisterController {
    @Autowired
    private UserService userService;


    @RequestMapping(value = {"/register"}, method = RequestMethod.GET)
    public String getRegisterPage(Model model) {
        model.addAttribute("registerForm", new RegisterForm());
        model.addAttribute("error", false);
        return "register";
    }

    @RequestMapping(value = {"/register"}, method = RequestMethod.POST)
    public String register(@ModelAttribute("registerForm") RegisterForm registerForm, BindingResult bindingResult, Model model, HttpServletRequest request) {
        if (!validateForm(registerForm)) {
            model.addAttribute("error", true);
            return "register";
        }
        userService.register(registerForm);
        return "redirect:/login";
    }

    private boolean validateForm(RegisterForm registerForm) {
        User user = userService.findByNickname(registerForm.getUsername());
        if (user != null) return false;
        if (Strings.isBlank(registerForm.getUsername())
                || Strings.isBlank(registerForm.getName())
                || Strings.isBlank(registerForm.getSurname())
                || Strings.isBlank(registerForm.getPassword())) {
            return false;
        }
        return true;
    }
}