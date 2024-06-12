package com.example.LocalGlovo.users.Dto;



import java.time.LocalDate;
import java.util.EnumSet;

public record PostCrearUserDto(String email,
                               String name,
                               String lastName,
                               String password,
                               String fotoUrl,
                               String phoneNumber,
                               LocalDate nacimiento) {
}