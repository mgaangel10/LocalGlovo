package com.example.LocalGlovo.valoracion.models;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.users.model.Usuario;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Valoracion {
    @EmbeddedId
    private ValoracionId id;

    @ManyToOne
    @MapsId("usuarioId")
    @JsonBackReference
    private Usuario usuarioV;

    @ManyToOne
    @MapsId("comercioId")
    @JsonBackReference
    private Comercio comercioV;

    private double rating;
}
