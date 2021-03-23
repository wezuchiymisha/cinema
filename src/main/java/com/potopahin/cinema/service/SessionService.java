package com.potopahin.cinema.service;

import com.potopahin.cinema.entity.*;
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

    public List<PlaceUI> getPlacesForSession(Long sessionId, Long userId) {
        List<PlaceUI> places = placeService.getAll().stream().map(place -> new PlaceUI(place, EPlaceStatus.FREE, true)).collect(Collectors.toList());
        List<Place> unablePlaces = ticketService.listTicketsBySession(sessionId).stream().map(Ticket::getPlace).collect(Collectors.toList());
        List<Place> cartPlaces = ticketService.listCartTicketsBySession(sessionId, userId).stream().map(Ticket::getPlace).collect(Collectors.toList());
        for (PlaceUI placeUI: places) {
            if (unablePlaces.contains(placeUI.getPlace())) {
                placeUI.setStatus((cartPlaces.contains(placeUI.getPlace())) ? EPlaceStatus.IN_CART : EPlaceStatus.BUSY);
                placeUI.setEnabled(false);
            }
        }
        return places;
    }
}
