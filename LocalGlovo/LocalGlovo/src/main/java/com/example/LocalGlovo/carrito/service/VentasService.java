package com.example.LocalGlovo.carrito.service;

import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.models.LineaCarrito;
import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.carrito.repository.CarritoRepo;
import com.example.LocalGlovo.carrito.repository.VentasRepo;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.users.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VentasService {

    private final VentasRepo ventasRepo;
    private final CarritoRepo carritoRepo;

    public Ventas obtenerventa(LocalDate localDate){
        List<Carrito> carritos = carritoRepo.findAll();
        List<Ventas> ventas = ventasRepo.findAll();
        double total = carritos.stream().mapToDouble(Carrito::getTotal).sum();
        List<Producto> productos = carritos.stream()
                .flatMap(carrito -> carrito.getLineasCarrito().stream())
                .map(LineaCarrito::getProducto)
                .collect(Collectors.toList());

        List<Usuario> usuarios = carritos.stream()
                .map(Carrito::getUsuario)
                .distinct()
                .collect(Collectors.toList());


        if (ventas.isEmpty()){
            throw new RuntimeException("no hay ventas para ese dia");
        }else{
            ventas.get(0).setTotal(total);
            ventas.get(0).setUsuarios(usuarios);
            ventas.get(0).setProductos(productos);


            return ventasRepo.save(ventas.get(0));
        }




    }

}
