package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.service.SessionService;
import com.potopahin.cinema.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class SessionController {
    @Autowired
    private SessionService sessionService;

    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/session/{sessionId}", method = RequestMethod.GET)
    public String showForm(@PathVariable("sessionId") Long sessionId, Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("session", sessionService.getSessionById(sessionId));
        model.addAttribute("places", sessionService.getPlacesForSession(sessionId));

        return "sessionPage";
    }

    @RequestMapping(value = "/session", method = RequestMethod.POST)
    public String submit(@RequestParam("chosenSession") Long chosenSession, @RequestParam("chosenPlace") Long chosenPlace,
                         HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        ticketService.reserveTicket(chosenSession, chosenPlace, user.getId());
        return "redirect:personal/" + user.getId().toString();
    }
}
