package com.potopahin.cinema.service;

import com.potopahin.cinema.entity.Place;
import com.potopahin.cinema.entity.PlaceUI;
import com.potopahin.cinema.entity.Session;
import com.potopahin.cinema.entity.Ticket;
import com.potopahin.cinema.repository.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SessionService {
    @Autowired
    private SessionRepository sessionRepository;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private PlaceService placeService;

    public List<Session> getSessions() {
        return sessionRepository.findAll();
    }

    public Session getSessionById(Long sessionId) {
        return sessionRepository.getOne(sessionId);
    }

    public List<PlaceUI> getPlacesForSession(Long sessionId) {
        List<PlaceUI> places = placeService.getAll().stream().map(place -> new PlaceUI(place, true)).collect(Collectors.toList());
        List<Place> unablePlaces = ticketService.listTicketsBySession(sessionId).stream().map(Ticket::getPlace).collect(Collectors.toList());
        for (PlaceUI placeUI: places) {
            if (unablePlaces.contains(placeUI.getPlace())) {
                placeUI.setEnabled(false);
            }
        }
        return places;
    }
}
