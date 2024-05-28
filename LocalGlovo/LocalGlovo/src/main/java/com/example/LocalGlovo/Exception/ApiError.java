package com.example.LocalGlovo.Exception;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;

public class ApiError {

    private HttpStatus status;

    @JsonFormat(shape= JsonFormat.Shape.STRING, pattern="dd/MM/yyy hh:mm:ss")
    private LocalDateTime date;

    private String message;

    public ApiError(HttpStatus status, String message) {
        super();
        this.status = status;
        this.date = LocalDateTime.now();
        this.message = message;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }



}
