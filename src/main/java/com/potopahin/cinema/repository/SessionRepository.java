package com.potopahin.cinema.repository;

import com.potopahin.cinema.entity.Film;
import com.potopahin.cinema.entity.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SessionRepository extends JpaRepository<Session, Long> {

}