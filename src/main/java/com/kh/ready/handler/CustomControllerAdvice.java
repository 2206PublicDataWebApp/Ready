package com.kh.ready.handler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.HttpServerErrorException.InternalServerError;
import org.springframework.web.servlet.NoHandlerFoundException;



@ControllerAdvice
public class CustomControllerAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomControllerAdvice.class);
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String notFound(NoHandlerFoundException e) {
		logger.error(e.getMessage());
		return "exception/notFoundPage";
	}
	
	@ExceptionHandler(InternalServerError.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String except(Exception e) {
		logger.error(e.getMessage());
		return "exception/something";
	}
	
}
