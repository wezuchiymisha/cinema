package com.potopahin.cinema.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "place")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Place {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer num;

    private Integer row;
}
