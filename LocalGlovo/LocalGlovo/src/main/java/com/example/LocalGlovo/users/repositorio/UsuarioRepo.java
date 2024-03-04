package com.example.LocalGlovo.users.repositorio;



import com.example.LocalGlovo.users.model.User;
import com.example.LocalGlovo.users.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UsuarioRepo extends JpaRepository<Usuario, UUID> {
    Optional<Usuario> findFirstByEmail(String email);
    Usuario findByEmail(String email);
    boolean existsByEmailIgnoreCase(String email);
    List<Usuario> findByEnabledFalse();

    @Query("""
            select new com.example.LocalGlovo.users.Dto.GetUsuario(
            u.username,
              u.name,
              u.lastName,
              u.phoneNumber,
              u.fotoUrl
            
            )
            from Usuario u
            """)
    User getUsuario();


}