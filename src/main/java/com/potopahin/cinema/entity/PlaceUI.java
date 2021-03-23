package com.potopahin.cinema.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class PlaceUI {
    private Place place;
    private boolean enabled;
}
