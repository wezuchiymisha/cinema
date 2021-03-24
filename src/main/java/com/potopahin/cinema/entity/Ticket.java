package com.potopahin.cinema.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ticket")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Ticket {
    public Ticket(Date created, Session session, Place place, User user, ETicketStatus status) {
        this.created = created;
        this.session = session;
        this.place = place;
        this.user = user;
        this.status = status;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Date created;

    @ManyToOne
    @JoinColumn(foreignKey = @ForeignKey(name = "TICKET_SESSION_ID_SESSION_FK"))
    private Session session;

    @ManyToOne
    @JoinColumn(foreignKey = @ForeignKey(name = "TICKET_PLACE_ID_PLACE_FK"))
    private Place place;

    @ManyToOne
    @JoinColumn(foreignKey = @ForeignKey(name = "TICKET_USER_ID_USER_FK"))
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(length = 45)
    private ETicketStatus status;
}
