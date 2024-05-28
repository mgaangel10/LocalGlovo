package com.example.LocalGlovo.comercios.service;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.repository.FavoritoRepo;
import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ComercioService {

    private final ComercioRepo comercioRepo;
    private final FavoritoRepo favoritoRepo;

    public Comercio crearComercio(PostCrearComercio postCrearComercio){

        CategoriaComercios comercios = CategoriaComercios.valueOf(postCrearComercio.categorias().toUpperCase());
        if (comercios == null){
            throw new GlobalException("Categoria de comercio no validas");
        }

        if (postCrearComercio.categorias().isEmpty()&&postCrearComercio.latitud()==0&&postCrearComercio.longitud()==0&&postCrearComercio.name().isEmpty()&&postCrearComercio.imagen().isEmpty()&&postCrearComercio.nameDirection().isEmpty()){
            throw new GlobalException("Todos los campos son obligatorios");
        }
        if (postCrearComercio.name().isEmpty()){
            throw new GlobalException("El campo nombre no puede estar vacio");
        }
        if (postCrearComercio.latitud()==0){
            throw new GlobalException("El campo latitud no puede estar vacio");
        }
        if (postCrearComercio.longitud()==0){
            throw new GlobalException("EL campo longitud no puede estar vacio");
        }
        if (postCrearComercio.imagen().isEmpty()){
            throw new GlobalException("El campo imagen no puede estar vacio");
        }
        if (postCrearComercio.nameDirection().isEmpty()){
            throw new GlobalException("El campo nombre de direccion no puede estar vacio");
        }

        Comercio comercio = Comercio.builder()
                .name(postCrearComercio.name())
                .latitud(postCrearComercio.latitud())
                .longitud(postCrearComercio.longitud())
                .nameDirection(postCrearComercio.nameDirection())
                .categorias(EnumSet.of(comercios))
                .imagen(postCrearComercio.imagen())

                .build();
        return comercioRepo.save(comercio);
    }
    public List<Comercio> findByNombre(String name){

List<Comercio> comercios = comercioRepo.findAll();
        List<Comercio> comercios1 = comercios.stream().filter(c-> c.getName().toLowerCase().contains(name) ||
                c.getNameDirection().toLowerCase().contains(name) ).collect(Collectors.toList());

    return comercios1;

    }
    public List<String> listadoDeCategorias(){
        List<String> categorias = Arrays.stream(CategoriaComercios.values()).map(Enum::name).collect(Collectors.toList());
        return categorias;
    }
    public List<Comercio> listadoProyectosGoogleMaps(){
        return comercioRepo.findAll();
    }
    public List<GetListComercios> getComerciosPorCategoria(CategoriaComercios categoria) {
        return comercioRepo.findByCategoriasContains(categoria);
    }

    public Page<GetListComercios> listarComercios(Pageable pageable){
        Page<GetListComercios> getListComercios = comercioRepo.getListComercios(pageable);
        if (getListComercios.isEmpty()){
            throw new RuntimeException("No hay comercios");
        }else{
            return comercioRepo.getListComercios(pageable);
        }
    }

    public Comercio finfbyid(UUID uuid){
        Optional<Comercio> comercio = comercioRepo.findById(uuid);

        if (comercio.isEmpty()){
            throw new RuntimeException("ningun comercio por el id: "+uuid);
        }else{
            return comercio.get();
        }
    }

    public void elimarComercio(UUID comercioId){
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);

        if (comercio.isEmpty()){
            throw new RuntimeException("no se ha encontrado el comercio");
        }else{
            List<Favorito> favoritoList = comercio.get().getFavoritoList();
            favoritoList.forEach(favorito -> {comercio.get().getFavoritoList();
            favoritoRepo.delete(favorito);});

            comercioRepo.delete(comercio.get());
        }
    }

    public Comercio editarComercio(UUID comerciId,PostCrearComercio postCrearComercio){
        Optional<Comercio> comercio = comercioRepo.findById(comerciId);

        if (comercio.isEmpty()){
            throw new RuntimeException("no se encuentra el comercio");
        }else{
            CategoriaComercios comercios = CategoriaComercios.valueOf(postCrearComercio.categorias().toUpperCase());
            if (comercios == null){
                throw new RuntimeException("Categoria de comercio no validas");
            }
           comercio.get().setName(postCrearComercio.name());
            comercio.get().setImagen(postCrearComercio.imagen());
            comercio.get().setLatitud(postCrearComercio.latitud());
            comercio.get().setLongitud(postCrearComercio.longitud());
            comercio.get().setCategorias(EnumSet.of(comercios));
            comercio.get().setNameDirection(postCrearComercio.nameDirection());
            return comercioRepo.save(comercio.get());
        }

    }

    public int totalLikes(UUID comercioId){
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);

        if (comercio.isPresent()){
            return comercio.get().getFavoritoList().size();
        }else {
            throw new RuntimeException("No hay comercios con ese id");
        }
    }
}
