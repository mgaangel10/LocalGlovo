package com.example.LocalGlovo.carrito.controller;

import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.carrito.service.VentasService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequiredArgsConstructor
public class VentasController {

    private final VentasService ventasService;


    @GetMapping("administrador/ver/ventas/{localDate}")
    public ResponseEntity<Ventas> verVentas(@PathVariable LocalDate localDate){
        Ventas ventas = ventasService.obtenerventa(localDate);
        return ResponseEntity.ok(ventas);

    }
}
