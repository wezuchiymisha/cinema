package com.potopahin.cinema.repository;

import com.potopahin.cinema.entity.Film;
import com.potopahin.cinema.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FilmRepository extends JpaRepository<Film, Long> {

}