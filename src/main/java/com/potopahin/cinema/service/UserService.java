package com.potopahin.cinema.service;

import com.potopahin.cinema.entity.ERole;
import com.potopahin.cinema.entity.Role;
import com.potopahin.cinema.entity.User;
import com.potopahin.cinema.form.RegisterForm;
import com.potopahin.cinema.repository.RoleRepository;
import com.potopahin.cinema.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    public User findByNickname(String nickname) {
        return userRepository.findAll().stream().filter(user -> user.getUsername().equals(nickname)).findFirst().orElse(null);
    }

    public User register(RegisterForm registerForm) {
        User user = new User(registerForm.getUsername(), registerForm.getName(),
                registerForm.getSurname(), registerForm.getPassword(),
                getUserRole());
        return userRepository.save(user);
    }

    private Role getUserRole() {
        return roleRepository.findAll().stream().filter(role -> role.getName().equals(ERole.ROLE_READER)).findFirst().orElse(null);
    }
}
