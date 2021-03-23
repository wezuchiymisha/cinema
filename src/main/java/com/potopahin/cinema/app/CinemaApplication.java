package com.potopahin.cinema.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories("com.potopahin.cinema.*")
@ComponentScan(basePackages = { "com.potopahin.cinema.*" })
@EntityScan("com.potopahin.cinema.*")
public class CinemaApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(CinemaApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(CinemaApplication.class, args);
	}

}
