package com.example.LocalGlovo.productos.service;


import ch.qos.logback.core.joran.conditional.IfAction;
import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.files.service.FicheroService;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.Dto.PostProductoDto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.repository.IngredientesRepo;
import com.example.LocalGlovo.productos.repository.ProdcutoRepo;
import lombok.RequiredArgsConstructor;
import org.hibernate.FetchMode;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductoService {
    private final ProdcutoRepo prodcutoRepo;
    private final ComercioRepo comercioRepo;
    private final IngredientesRepo ingredientesRepo;
    private final FicheroService ficheroService;
    public Producto crearProducto(PostProductoDto postProductoDto, UUID comercioId, MultipartFile file){
        String filename = ficheroService.storeAndReturnFilename(file);
        Producto producto = new Producto();
        if (postProductoDto.precio()<=0&&postProductoDto.name().isEmpty()&&postProductoDto.imagen().isEmpty()){
            throw new GlobalException("No puedes enviar el formulario vacio");
        }
        if (!filename.isEmpty()){
            producto.setImagen(filename);
        }else {
            throw new GlobalException("El campo imagen debe de contener una imagen");
        }
        if (!postProductoDto.name().isEmpty()){
            producto.setName(postProductoDto.name());
        }else {
            throw new GlobalException("El campo nombre no puede estar vacio");
        }

        if (postProductoDto.precio()>0) {
            producto.setPrecio(postProductoDto.precio());
        }else {
            throw new GlobalException("El precio no puede ser negativo o no puede ser cero");
        }

        producto.setDisponible(postProductoDto.disponible());
        //producto.setComercio(postProductoDto.comercio());
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);
        comercio.get().getProductos().add(producto);

        return prodcutoRepo.save(producto);
    }



    public Page<GetListProducto> listarProductos(Pageable pageable){
        Page<GetListProducto> getListProductos = prodcutoRepo.getListProducto(pageable);
        if (getListProductos.isEmpty()){
            throw new GlobalException("No hay productos");
        }else{
            return prodcutoRepo.getListProducto(pageable);
        }
    }

   /* public Comercio añadirProductosAComercio(String nombreComercio, List<UUID> idsProductos) {

        Comercio comercio = comercioRepo.findByName(nombreComercio);


        List<Producto> productos = prodcutoRepo.findAllById(idsProductos);
        Set<Producto> productosComercio = comercio.getProductos();
        productosComercio.addAll(productos);
        comercio.setProductos(productosComercio);
        productos.get(0).setComercio(comercio);
        prodcutoRepo.save(productos.get(0));

       return comercioRepo.save(comercio);
    }*/

    public Ingredientes finByIdIngredientes(UUID uuid){
        Optional<Ingredientes> ingredientes = ingredientesRepo.findById(uuid);
        if (ingredientes.isEmpty()){
            throw new GlobalException("No hay ingredientes con ese id");
        }else{
            return ingredientes.get();
        }

    }


    public Producto buscarPorID(UUID uuid){
        Optional<Producto> productoOptional = prodcutoRepo.findById(uuid);
        if (productoOptional.isEmpty()){
            throw new GlobalException("No se ha encontrado el producto");
        }else{
          return   productoOptional.get();
        }
    }

    public Producto buscarPorIdV2(UUID uuid){
        Optional<Producto> productoOptional = prodcutoRepo.findProductoWithComercioById(uuid);
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
            throw new GlobalException("no existe el producto");
        }else{
            List<Comercio> comercios = comercioRepo.findAll();
            for (Comercio comercio : comercios) {
                comercio.getProductos().remove(producto.get());
                comercioRepo.save(comercio);
            }
            prodcutoRepo.delete(producto.get());
        }
    }


    public Ingredientes crearIngredientes(Ingredientes ingredientes,UUID productoId,MultipartFile file){
        String filename = ficheroService.storeAndReturnFilename(file);
        Ingredientes ingredientes1 = new Ingredientes();
        if (!filename.isEmpty()){
            ingredientes1.setImagen(filename);
        }else {
            throw new GlobalException("El campo imagen no puede ser nulo");
        }
        if (!ingredientes.getName().isEmpty()){
            ingredientes1.setName(ingredientes.getName());
        }else {
            throw new GlobalException("El campo nombre no puede estar vacio");
        }

        Optional<Producto> producto = prodcutoRepo.findById(productoId);
        producto.get().getIngredientes().add(ingredientes1); // Aquí se cambió 'ingredientes' por 'ingredientes1'

        return ingredientesRepo.save(ingredientes1);
    }

    public void eliminarIngrediente(UUID ingredienteId){
        Optional<Ingredientes> ingredienteOptional = ingredientesRepo.findById(ingredienteId);

        if (ingredienteOptional.isEmpty()) {
            throw new GlobalException("El ingrediente no se encuentra");
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
            if (postProductoDto.imagen().isEmpty()&&postProductoDto.name().isEmpty()&&postProductoDto.precio()<=0){
                throw new GlobalException("Todos los campos son obligatorios");
            }
            if (!postProductoDto.name().isEmpty()){
                producto.get().setName(postProductoDto.name());
            }else {
                throw new GlobalException("El campo nombre no puede estar vacio");
            }
            if (!postProductoDto.imagen().isEmpty()){
                producto.get().setImagen(postProductoDto.imagen());
            }else {
              throw new GlobalException("El campo imagen no puede estar vacio");
            }

            producto.get().setDisponible(postProductoDto.disponible());
            if (postProductoDto.precio()>0){
                producto.get().setPrecio(postProductoDto.precio());
            }else {
                throw new GlobalException("No puedes introducir un precio negativo o igual a cero");
            }

            return prodcutoRepo.save(producto.get());
        }

    }








}
