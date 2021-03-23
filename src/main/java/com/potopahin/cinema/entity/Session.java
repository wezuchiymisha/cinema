package com.potopahin.cinema.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "session")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Session {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Date startDateTime;

    private Integer price;

    @ManyToOne
    @JoinColumn(foreignKey = @ForeignKey(name = "SESSION_FILM_ID_FILM_FK"))
    private Film film;
}
