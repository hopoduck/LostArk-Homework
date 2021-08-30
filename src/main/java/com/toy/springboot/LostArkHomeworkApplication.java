package com.toy.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class LostArkHomeworkApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder bulider) {
		return bulider.sources(LostArkHomeworkApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(LostArkHomeworkApplication.class, args);
	}

}
