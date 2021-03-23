package com.potopahin.cinema.form;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RegisterForm {
    private String username;

    private String name;

    private String surname;

    private String password;
}
