package com.example.LocalGlovo.productos.service;


import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.Dto.PostProductoDto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.repository.ProdcutoRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductoService {
    private final ProdcutoRepo prodcutoRepo;
    private final ComercioRepo comercioRepo;
    public Producto crearProducto(PostProductoDto postProductoDto){
        Producto producto = new Producto();
        producto.setImagen(postProductoDto.imagen());
        producto.setName(postProductoDto.name());
        producto.setPrecio(postProductoDto.precio());
        producto.setDisponible(postProductoDto.disponible());

        Set<Ingredientes> ingredientes = postProductoDto.ingredientes();
        if (ingredientes == null) {
            ingredientes = new HashSet<>(); // Opcional: inicializa el conjunto si es nulo
        }
        producto.setIngredientes(ingredientes);

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
        // Buscar el comercio
        Comercio comercio = comercioRepo.findByName(nombreComercio);

        // Buscar los productos por su ID
        List<Producto> productos = prodcutoRepo.findAllById(idsProductos);

        // Añadir los productos al comercio
        Set<Producto> productosComercio = comercio.getProductos();
        productosComercio.addAll(productos);
        comercio.setProductos(productosComercio);

        // Guardar el comercio en la base de datos
       return comercioRepo.save(comercio);
    }


}
