package com.potopahin.cinema.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "film")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Film {
    public Film(String name, String description, Integer duration) {
        this.name = name;
        this.description = description;
        this.duration = duration;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100)
    private String name;

    @Column(length = 1000)
    private String description;

    private Integer duration;
}
