package com.example.LocalGlovo.files.controller;

import com.example.LocalGlovo.files.dto.RespuestaFichero;
import com.example.LocalGlovo.files.service.FicheroService;
import com.example.LocalGlovo.files.utils.MediaTypeUrlResource;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class FicheroController {

    private final FicheroService storageService;



    @PostMapping("/upload/files")
    public ResponseEntity<?> upload(@RequestPart("files") MultipartFile[] files) {

        //FileResponse response = uploadFile(file);

        List<RespuestaFichero> result = Arrays.stream(files)
                .map(this::uploadFile)
                .toList();

        return ResponseEntity
                //.created(URI.create(response.getUri()))
                .status(HttpStatus.CREATED)
                .body(result);
    }


    @PostMapping("/upload")
    public ResponseEntity<?> upload(@RequestPart("file") MultipartFile file) {

        RespuestaFichero response = uploadFile(file);

        return ResponseEntity.created(URI.create(response.getUri())).body(response);
    }

    private RespuestaFichero uploadFile(MultipartFile file) {
        String name = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(name)
                .toUriString();

        return RespuestaFichero.builder()
                .name(name)
                .size(file.getSize())
                .type(file.getContentType())
                .uri(uri)
                .build();
    }
    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename){
        MediaTypeUrlResource resource =
                (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
    }


}
