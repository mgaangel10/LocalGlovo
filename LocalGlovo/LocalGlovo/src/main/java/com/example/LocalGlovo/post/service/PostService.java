package com.example.LocalGlovo.post.service;

import com.example.LocalGlovo.files.service.FicheroService;
import com.example.LocalGlovo.post.dto.CreatePostDto;
import com.example.LocalGlovo.post.model.Post;
import com.example.LocalGlovo.post.repositorio.PostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository repository;
    private final FicheroService storageService;

    @Transactional
    public Post save(CreatePostDto createPostDto, MultipartFile file) {
        String filename = storageService.store(file);

        Post post = repository.save(
                Post.builder()
                        .title(createPostDto.getTitle())
                        .image(filename)
                        .build()
        );
        return post;
    }

    public List<Post> findAll() { return repository.findAll(); }




}
