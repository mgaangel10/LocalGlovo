package com.example.LocalGlovo.Favoritos.models;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.users.model.Usuario;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Favorito {
    @EmbeddedId
    private FavoritoId id;

    @ManyToOne
    @MapsId("usuarioId")
    @JsonBackReference
    private Usuario usuario;

    @ManyToOne
    @MapsId("comercioId")
    @JsonBackReference
    private Comercio comercio;
}
