package com.example.LocalGlovo.productos.repository;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProdcutoRepo extends JpaRepository<Producto, UUID> {

    @Query("""
            select new com.example.LocalGlovo.productos.Dto.GetListProducto(
            c.imagen,
            c.name,
            c.precio,
            c.disponible
           
            )
            from Producto c
            """)
    Page<GetListProducto> getListProducto(Pageable pageable);

    List<Producto> findAllByIngredientesContaining(Ingredientes ingrediente);

    Optional<Producto> findByNameIgnoreCase(String nombre);


    @Query("SELECT p FROM Producto p JOIN FETCH p.comercio WHERE p.id = ?1 ")
    Optional<Producto> findProductoWithComercioById( UUID id);






}
