package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.form.LoginForm;
import com.potopahin.cinema.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;


	@RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
	public String getLoginPage(Model model, String error, String logout, HttpServletRequest request) {
		model.addAttribute("loginForm", new LoginForm());
		model.addAttribute("error", false);
		return "login";
	}

	@RequestMapping(value = {"/", "/login"}, method = RequestMethod.POST)
	public String login(@ModelAttribute("loginForm") LoginForm userForm, BindingResult bindingResult, Model model, HttpServletRequest request) {
		User user = userService.findByNickname(userForm.getUsername());
		if (user != null && user.getPassword().equals(userForm.getPassword())) {
            request.getSession().setAttribute("user", user);
			return "redirect:/welcome";
		}
		model.addAttribute("error", true);
		return "login";
	}


	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
        request.getSession().setAttribute("user", null);
        request.getSession().setAttribute("cart", null);
	    return "redirect:/login";
	}
}