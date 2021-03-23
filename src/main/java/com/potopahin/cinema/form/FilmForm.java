package com.potopahin.cinema.form;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FilmForm {
    private String name;
    private String description;
    private String duration;
}
