package com.example.LocalGlovo.carrito.service;

import com.example.LocalGlovo.carrito.Dto.GetCarritoDto;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.models.Estado;
import com.example.LocalGlovo.carrito.models.LineaCarrito;
import com.example.LocalGlovo.carrito.repository.CarritoRepo;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.repository.ProdcutoRepo;
import com.example.LocalGlovo.users.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class CarritoService {

    private final Map<UUID, LineaCarrito> carrito = new HashMap<>();
    private final CarritoRepo carritoRepository;
    private final ProdcutoRepo productoRepository;


    public List<Carrito> findAllTodosLosCarritos(){
        return carritoRepository.findAll();
    }





    public Optional<Carrito> buscarCarritoPorId(UUID id){
        Optional<Carrito> carrito1 = carritoRepository.findById(id);
        if (carrito1.isPresent()){
            return carrito1;
        }else{
            throw new RuntimeException("no se encuentra el carrito ");
        }
    }

    public void agregarProductoAlCarrito(Usuario usuario, Producto producto) {
        Carrito carrito = buscarCarritoActivoDelUsuario(usuario);
        if (carrito == null){
            carrito = crearUnCarrito(usuario);
        }

        LineaCarrito lineaExistente = carrito.getLineasCarrito().stream()
                .filter(linea -> linea.getProducto().getId().equals(producto.getId()))
                .findFirst()
                .orElse(null);

        if (lineaExistente != null) {
            lineaExistente.aumentarCantidad();
        } else {
            LineaCarrito nuevaLinea = new LineaCarrito(producto, 1);
            nuevaLinea.setCarrito(carrito);
            carrito.getLineasCarrito().add(nuevaLinea);
        }

        carritoRepository.save(carrito);
        actualizarTotalCarrito(carrito);
        System.out.println(carrito.getId());
    }


    public void actualizarTotalCarrito(Carrito carrito) {
        double total = carrito.getLineasCarrito().stream()
                .mapToDouble(LineaCarrito::getTotal)
                .sum();
        Integer cantidad = carrito.getLineasCarrito().stream()
                .mapToInt(LineaCarrito::getCantidad)
                .sum();

        carrito.setCantidad(cantidad);
        carrito.setTotal(total);
        carritoRepository.save(carrito);
    }



    public void eliminarCarritoPorId(UUID id) {
        Optional<Carrito> carritoOptional = carritoRepository.findById(id);
        if (carritoOptional.isPresent()) {
            Carrito carrito = carritoOptional.get();
            carrito.getLineasCarrito().clear();
            carritoRepository.deleteById(id);
        } else {
            throw new RuntimeException("No se encontró el carrito con ID: " + id);
        }
    }




    public void eliminarProductoDelCarrito(Carrito carrito, Producto producto) {
        LineaCarrito lineaCarrito = carrito.getLineasCarrito().stream()
                .filter(linea -> linea.getProducto().getId().equals(producto.getId()))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Producto no encontrado en el carrito"));

        lineaCarrito.disminuirCantidad();

        if (lineaCarrito.getCantidad() <= 0) {
            carrito.getLineasCarrito().remove(lineaCarrito);
        }

        carritoRepository.save(carrito);
        actualizarTotalCarrito(carrito);
    }


    public List<LineaCarrito> obtenerProductosEnCarrito(UUID id) {
        Carrito carrito = carritoRepository.findById(id).orElseThrow(() -> new RuntimeException("Carrito no encontrado"));
        carrito.setTotal(calcularTotalCarrito(carrito));
        carritoRepository.save(carrito);
        return new ArrayList<>(carrito.getLineasCarrito());
    }


    public double calcularTotalCarrito(Carrito carrito) {
        return carrito.getLineasCarrito().stream()
                .mapToDouble(LineaCarrito::getTotal)
                .sum();
    }


    public void vaciarCarrito(UUID id) {
        Carrito carrito = carritoRepository.findById(id).orElseThrow(() -> new RuntimeException("Carrito no encontrado"));
        carrito.setCantidad(0);
        carrito.getLineasCarrito().clear();
        carrito.setTotal(0);
        carritoRepository.save(carrito);
    }

    public Carrito buscarCarritoActivoDelUsuario(Usuario usuario) {
        return carritoRepository.buscarCarritoActivoDelUsuario(usuario, Estado.ACTIVO)
                .orElse(null);
    }
    public Carrito crearUnCarrito(Usuario usuario) {
        Carrito carrito = new Carrito();
        carrito.setUsuario(usuario);
        carrito.setEstado(Estado.ACTIVO);
        carritoRepository.save(carrito);
        return carrito;
    }

    public List<GetCarritoDto> listarCarrito(){
        return carritoRepository.getListCarrito();
    }
}