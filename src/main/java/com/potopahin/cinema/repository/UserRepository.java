package com.potopahin.cinema.repository;

import com.potopahin.cinema.entity.User;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {

}
