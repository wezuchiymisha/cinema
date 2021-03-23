package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.ERole;
import com.potopahin.cinema.entity.Film;
import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.form.FilmForm;
import com.potopahin.cinema.repository.FilmRepository;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class EditFilmController {

    @Autowired
    private FilmRepository filmRepository;

    @RequestMapping(value = "/admin/film/create", method = RequestMethod.GET)
    public String showFormCreate(Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else if (user.getRole().getName().equals(ERole.ROLE_READER)) {
            return "redirect:/welcome";
        }
        model.addAttribute("filmForm", new FilmForm());
        model.addAttribute("isEdit", false);
        model.addAttribute("filmId", -1L);
        return "editFilm";
    }

    @RequestMapping(value = "/admin/film/{filmId}", method = RequestMethod.GET)
    public String showEdit(@PathVariable("filmId") Long filmId, Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        } else if (user.getRole().getName().equals(ERole.ROLE_READER)) {
            return "redirect:/welcome";
        }
        Film film = filmRepository.findById(filmId).get();
        model.addAttribute("filmForm", new FilmForm(film.getName(), film.getDescription(), film.getDuration().toString()));
        model.addAttribute("isEdit", true);
        model.addAttribute("filmId", film.getId());
        return "editFilm";
    }

    @RequestMapping(value = {"/admin/film"}, method = RequestMethod.POST)
    public String save(@ModelAttribute("filmForm") FilmForm filmForm,
                       @RequestParam("isEdit") Boolean isEdit,
                       @RequestParam("filmId") Long filmId, Model model) {
        if (!validateForm(filmForm)) {
            model.addAttribute("error", true);
            return "editFilm";
        }
        Film film = new Film();
        if (isEdit) {
            film = filmRepository.getOne(filmId);
        }
        film.setDescription(filmForm.getDescription());
        film.setName(filmForm.getName());
        film.setDuration(Integer.parseInt(filmForm.getDuration()));
        filmRepository.save(film);
        return "redirect:/admin/films";
    }

    private boolean validateForm(FilmForm filmForm) {
        if (Strings.isBlank(filmForm.getName())
                || Strings.isBlank(filmForm.getDescription())
                || Strings.isBlank(filmForm.getDuration())) {
            return false;
        }
        return true;
    }
}
