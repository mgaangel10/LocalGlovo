package com.example.LocalGlovo.post.controller;

import com.example.LocalGlovo.post.dto.CreatePostDto;
import com.example.LocalGlovo.post.model.Post;
import com.example.LocalGlovo.post.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController

@RequiredArgsConstructor
public class PostController {

    private final PostService service;

    @GetMapping("administrador/post/")
    public ResponseEntity<List<Post>> getAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @PostMapping("administrador/post/")
    public ResponseEntity<Post> create(
            @RequestPart("file") MultipartFile file,
            @RequestPart("post") CreatePostDto newPost
    ) {
        Post post = service.save(newPost,file);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(post);
    }


}
