package com.example.LocalGlovo.valoracion.service;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.repositorio.UsuarioRepo;
import com.example.LocalGlovo.valoracion.models.Valoracion;
import com.example.LocalGlovo.valoracion.models.ValoracionId;
import com.example.LocalGlovo.valoracion.repository.ValoracionRepo;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ValoracionService {

     final ValoracionRepo valoracionRepo;
     final UsuarioRepo usuarioRepo;
     final ComercioRepo comercioRepo;

    public Comercio obtenerMediaValoracion(UUID usuarioId,UUID comercioId,double rating){
        Optional<Usuario> usuario = usuarioRepo.findById(usuarioId);
        Optional<Comercio> comercio = comercioRepo.findById(comercioId);

        Valoracion valoracion = Valoracion.builder()
                .id(new ValoracionId(usuarioId,comercioId))
                .comercioV(comercio.get())
                .usuarioV(usuario.get())
                .rating(rating)
                .build();
        valoracionRepo.save(valoracion);
        List<Valoracion> valoraciones = valoracionRepo.findAllByComercioV(comercio.get());
        double media = valoraciones.stream()
                .mapToDouble(Valoracion::getRating)
                .average()
                .orElse(0.0);
        Optional<Comercio> comercio1 = comercio;
        comercio1.get().setRating(media);
        comercioRepo.save(comercio1.get());
        return comercio1.get();
    }
}
