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
import java.util.stream.Collectors;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class CartPageController {

    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/cart/{userId}", method = RequestMethod.GET)
    public String showForm(@PathVariable("userId") Long userId, Model model, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.getId().equals(userId)) {
            return "redirect:/welcome";
        }
        List<Ticket> cart = ticketService.listCartTicketsByUser(userId);

        Integer sumPrice = cart.stream().map(ticket -> ticket.getSession().getPrice()).reduce(0, (a, b) -> a + b);
        model.addAttribute("tickets", cart);
        model.addAttribute("sumPrice", sumPrice);
        model.addAttribute("haveTickets", !cart.isEmpty());
        return "cart";
    }

    @RequestMapping(value = "/cart/removeTicket", method = RequestMethod.POST)
    public String submitRemoveTicket(@RequestParam("chosenTicket") Long chosenTicket, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        ticketService.removeTicketFromCart(chosenTicket);
        return "redirect:/cart/" + user.getId().toString();
    }

    @RequestMapping(value = "/cart/pay", method = RequestMethod.POST)
    public String submitRemoveTicket(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        ticketService.listCartTicketsByUser(user.getId()).forEach(ticket -> ticketService.payForTicket(ticket.getId()));
        return "redirect:/personal/" + user.getId().toString();
    }
}
