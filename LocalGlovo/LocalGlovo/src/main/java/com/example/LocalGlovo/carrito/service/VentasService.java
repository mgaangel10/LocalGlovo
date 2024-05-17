package com.example.LocalGlovo.carrito.service;

import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.models.LineaCarrito;
import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.carrito.repository.CarritoRepo;
import com.example.LocalGlovo.carrito.repository.VentasRepo;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.users.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VentasService {

    private final VentasRepo ventasRepo;
    private final CarritoRepo carritoRepo;
    private final ComercioRepo comercioRepo;


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
            ventas.get(0).getProductos().get(0).getComercio();
            List<Ventas> ventas1 = ventas.stream().filter(ventas2 -> ventas2.getFecha().isEqual(localDate)).collect(Collectors.toList());


             ventasRepo.save(ventas.get(0));
             return ventas1.get(0);
        }




    }

    public List<Comercio> comercioConMasLikes(){
        List<Comercio> comercios = comercioRepo.findAll();
        List<Comercio> resultado = comercios.stream().sorted((c1,c2)->{
            int numero1 = c1.getFavoritoList().size();
            int numero2 = c2.getFavoritoList().size();
            return Integer.compare(numero2, numero1);
        }).limit(5).collect(Collectors.toList());
        return resultado;
    }

}
