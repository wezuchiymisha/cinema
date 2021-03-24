package com.potopahin.cinema.service;

import com.potopahin.cinema.entity.ETicketStatus;
import com.potopahin.cinema.entity.Session;
import com.potopahin.cinema.entity.Ticket;
import com.potopahin.cinema.repository.SessionRepository;
import com.potopahin.cinema.repository.TicketRepository;
import com.potopahin.cinema.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TicketService {
    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private UserRepository userRepository;

    public List<Ticket> listTicketsBySession(Long sessionId) {
        return ticketRepository.findAll()
                .stream()
                .filter(ticket->ticket.getSession().getId().equals(sessionId))
                .collect(Collectors.toList());

    }

    public List<Ticket> listCartTicketsBySession(Long sessionId, Long userId) {
        return ticketRepository.findAll()
                .stream()
                .filter(ticket->ticket.getUser().getId().equals(userId))
                .filter(ticket->ticket.getSession().getId().equals(sessionId))
                .filter(ticket->ticket.getStatus().equals(ETicketStatus.IN_CART))
                .collect(Collectors.toList());

    }

    public List<Ticket> listCartTicketsByUser(Long userId) {
        return ticketRepository.findAll()
                .stream()
                .filter(ticket->ticket.getUser().getId().equals(userId))
                .filter(ticket->ticket.getStatus().equals(ETicketStatus.IN_CART))
                .collect(Collectors.toList());
    }

    public List<Ticket> listPayedTicketsByUser(Long userId) {
        return ticketRepository.findAll()
                .stream()
                .filter(ticket->ticket.getUser().getId().equals(userId))
                .filter(ticket->ticket.getStatus().equals(ETicketStatus.PAYED))
                .collect(Collectors.toList());
    }

    public Ticket reserveTicket(Long sessionId, Long chosenPlace, Long userId) {
        Ticket ticket = new Ticket(new Date(), sessionService.getSessionById(sessionId),
                placeService.getById(chosenPlace), userRepository.getOne(userId), ETicketStatus.IN_CART);
        return ticketRepository.save(ticket);
    }

    public Ticket payForTicket(Long ticketId) {
        Ticket ticket = ticketRepository.getOne(ticketId);
        ticket.setStatus(ETicketStatus.PAYED);
        return ticketRepository.save(ticket);
    }

    public List<Ticket> listTicketsByUser(Long userId) {
        return ticketRepository.findAll()
                .stream()
                .filter(ticket->ticket.getUser().getId().equals(userId))
                .collect(Collectors.toList());
    }

    public void removeTicketFromCart(Long id) {
        Ticket ticket = ticketRepository.getOne(id);
        if (ticket.getStatus().equals(ETicketStatus.IN_CART)) {
            ticketRepository.delete(ticket);
        }
    }
}
