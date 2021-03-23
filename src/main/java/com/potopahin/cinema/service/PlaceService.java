package com.potopahin.cinema.service;

import com.potopahin.cinema.entity.Place;
import com.potopahin.cinema.entity.Ticket;
import com.potopahin.cinema.repository.PlaceRepository;
import com.potopahin.cinema.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PlaceService {
    @Autowired
    private PlaceRepository placeRepository;

    public List<Place> getAll() {
        return placeRepository.findAll();
    }

    public Place getById(Long id) {
        return placeRepository.findById(id).orElse(null);
    }
}
