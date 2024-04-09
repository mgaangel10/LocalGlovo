package com.example.LocalGlovo.Favoritos.service;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.models.FavoritoId;
import com.example.LocalGlovo.Favoritos.repository.FavoritoRepo;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.repositorio.UsuarioRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class FavoritoService {

    final FavoritoRepo favoritoRepo;
    final UsuarioRepo usuarioRepo;
    final ComercioRepo comercioRepo;

    public Comercio darAFavorito(UUID usuarioId,UUID comercioId){
        Optional<Usuario> usuario = usuarioRepo.findById(usuarioId);
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);

       Favorito favorito = Favorito.builder()
               .id(new FavoritoId(usuarioId,comercioId))
               .comercio(comercio.get())
               .usuario(usuario.get())

               .build();

       favoritoRepo.save(favorito);
       Optional<Comercio> comercio1 = comercio;

       return comercio1.get();

    }


    public List<Comercio> verFavoritoDeUsuario(UUID usuarioId){
        Optional<Usuario> usuario = usuarioRepo.findById(usuarioId);

        List<Comercio> comercios =  usuario.get().getFavoritos().stream().map(Favorito::getComercio).collect(Collectors.toList());

        return comercios;

    }

    public void  quitarDeFavorito(UUID usuarioId,UUID comercioId){


        Optional<Favorito> favorito = favoritoRepo.findById(new FavoritoId(usuarioId,comercioId));
        favoritoRepo.delete(favorito.get());

    }


}
