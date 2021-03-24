package com.potopahin.cinema.controller;

import com.potopahin.cinema.entity.Ticket;
import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class PersonalPageController {

    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/personal/{userId}", method = RequestMethod.GET)
    public String showForm(@PathVariable("userId") Long userId, Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.getId().equals(userId)) {
            return "redirect:/welcome";
        }
        List<Ticket> tickets = ticketService.listPayedTicketsByUser(userId);
        model.addAttribute("tickets", tickets);
        model.addAttribute("haveTickets", !tickets.isEmpty());
        return "personalPage";
    }
}
