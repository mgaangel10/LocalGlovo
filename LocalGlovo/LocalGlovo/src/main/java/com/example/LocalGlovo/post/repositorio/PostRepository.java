package com.example.LocalGlovo.post.repositorio;

import com.example.LocalGlovo.post.model.Post;
import jakarta.persistence.Id;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepository extends JpaRepository<Post, Long> {
}
