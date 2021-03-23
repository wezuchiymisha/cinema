package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.ERole;
import com.potopahin.cinema.entity.Film;
import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.form.FilmForm;
import com.potopahin.cinema.repository.FilmRepository;
import com.potopahin.cinema.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class AdminFilmsController {

    @Autowired
    private FilmRepository filmRepository;

    @RequestMapping(value = "/admin/films", method = RequestMethod.GET)
    public String showForm(Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else if (user.getRole().getName().equals(ERole.ROLE_READER)) {
            return "redirect:/welcome";
        }
        model.addAttribute("films", filmRepository.findAll());
        return "adminFilms";
    }
}
