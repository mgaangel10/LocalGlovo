package com.example.LocalGlovo.productos.service;


import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.Dto.PostProductoDto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.repository.IngredientesRepo;
import com.example.LocalGlovo.productos.repository.ProdcutoRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductoService {
    private final ProdcutoRepo prodcutoRepo;
    private final ComercioRepo comercioRepo;
    private final IngredientesRepo ingredientesRepo;
    public Producto crearProducto(PostProductoDto postProductoDto,UUID comercioId){
        Producto producto = new Producto();
        producto.setImagen(postProductoDto.imagen());
        producto.setName(postProductoDto.name());
        producto.setPrecio(postProductoDto.precio());
        producto.setDisponible(postProductoDto.disponible());
        //producto.setComercio(postProductoDto.comercio());
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);
        comercio.get().getProductos().add(producto);


        return prodcutoRepo.save(producto);
    }



    public Page<GetListProducto> listarProductos(Pageable pageable){
        Page<GetListProducto> getListProductos = prodcutoRepo.getListProducto(pageable);
        if (getListProductos.isEmpty()){
            throw new RuntimeException("No hay productos");
        }else{
            return prodcutoRepo.getListProducto(pageable);
        }
    }

    public Comercio añadirProductosAComercio(String nombreComercio, List<UUID> idsProductos) {

        Comercio comercio = comercioRepo.findByName(nombreComercio);


        List<Producto> productos = prodcutoRepo.findAllById(idsProductos);
        Set<Producto> productosComercio = comercio.getProductos();
        productosComercio.addAll(productos);
        comercio.setProductos(productosComercio);


       return comercioRepo.save(comercio);
    }

    public Ingredientes finByIdIngredientes(UUID uuid){
        Optional<Ingredientes> ingredientes = ingredientesRepo.findById(uuid);
        if (ingredientes.isEmpty()){
            throw new RuntimeException("No hay ingredientes con ese id");
        }else{
            return ingredientes.get();
        }

    }

    public Producto buscarPorID(UUID uuid){
        Optional<Producto> productoOptional = prodcutoRepo.findById(uuid);
        if (productoOptional.isEmpty()){
            throw new RuntimeException("no hay productos con ese id");
        }else{
          return   productoOptional.get();
        }
    }

    public void EliminarIngredientes(UUID uuid) {
        Optional<Ingredientes> ingredientesOptional = ingredientesRepo.findById(uuid);
        if (ingredientesOptional.isEmpty()) {
            throw new RuntimeException("No hay ingredientes con ese id");
        } else {
            ingredientesRepo.delete(ingredientesOptional.get());
        }
    }

    public void eliminarProducto(UUID productoId){
        Optional<Producto> producto = prodcutoRepo.findById(productoId);
        if (producto.isEmpty()){
            throw new RuntimeException("no existe el producto");
        }else{
            List<Comercio> comercios = comercioRepo.findAll();
            for (Comercio comercio : comercios) {
                comercio.getProductos().remove(producto.get());
                comercioRepo.save(comercio);
            }
            prodcutoRepo.delete(producto.get());
        }
    }


    public Ingredientes crearIngredientes(Ingredientes ingredientes,UUID productoId){

        Ingredientes ingredientes1 = Ingredientes.builder()
                .id(ingredientes.getId())
                .imagen(ingredientes.getImagen())
                .name(ingredientes.getName())
                .build();


         Optional<Producto> producto = prodcutoRepo.findById(productoId);
         producto.get().getIngredientes().add(ingredientes);

         prodcutoRepo.save(producto.get());
       return ingredientesRepo.save(ingredientes1);

    }
    public void eliminarIngrediente(UUID ingredienteId){
        Optional<Ingredientes> ingredienteOptional = ingredientesRepo.findById(ingredienteId);

        if (ingredienteOptional.isEmpty()) {
            throw new RuntimeException("El ingrediente no se encuentra");
        }

        Ingredientes ingrediente = ingredienteOptional.get();

        List<Producto> productos = prodcutoRepo.findAllByIngredientesContaining(ingrediente);
        for (Producto producto : productos) {
            producto.getIngredientes().remove(ingrediente);
        }

        ingredientesRepo.delete(ingrediente);
    }

    public Producto editarProdcuto(UUID porductoId,PostProductoDto postProductoDto){

        Optional<Producto> producto = prodcutoRepo.findById(porductoId);

        if (producto.isEmpty()){
            throw new RuntimeException("no se encuentra el producto");
        }else{
            producto.get().setName(postProductoDto.name());
            producto.get().setImagen(postProductoDto.imagen());
            producto.get().setDisponible(postProductoDto.disponible());
            producto.get().setPrecio(postProductoDto.precio());
            return prodcutoRepo.save(producto.get());
        }

    }






}
