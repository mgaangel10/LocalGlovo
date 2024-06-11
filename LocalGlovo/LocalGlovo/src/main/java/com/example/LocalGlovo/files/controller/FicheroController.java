package com.example.LocalGlovo.files.controller;

import com.example.LocalGlovo.files.dto.RespuestaFichero;
import com.example.LocalGlovo.files.service.FicheroService;
import com.example.LocalGlovo.files.utils.MediaTypeUrlResource;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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



    @Operation(summary = "Descargar para ver una imagen")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado y descargado la imagen ",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Resource.class)),
                            examples = {@ExampleObject(
                                    value = """
                                             
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename){
        MediaTypeUrlResource resource =
                (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
    }
    @Operation(summary = "Descargar para ver una imagen")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado y descargado la imagen ",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Resource.class)),
                            examples = {@ExampleObject(
                                    value = """
                                             
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("usuario/download/{filename:.+}")
    public ResponseEntity<Resource> getFileUsuario(@PathVariable String filename){
        MediaTypeUrlResource resource =
                (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
    }


    @Operation(summary = "Ver Todos los nombres de los archvios de la carpeta uploads")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrados archvios en la carpeta uploads ",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = String.class)),
                            examples = {@ExampleObject(
                                    value = """
                                             "fotoPruebaComercio.jpeg",
                                                 "fotoPruebaComercio_008187.jpeg",
                                                 "fotoPruebaComercio_008187_135241.jpeg",
                                                 "fotoPruebaComercio_008187_135241_016546.jpeg",
                                                 "fotoPruebaComercio_008187_135241_016546_313960.jpeg",
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("/administrador/all/files")
    public List<String> listAllFiles() {
        return storageService.loadAll().stream()
                .map(resource -> {
                    String filename = ((UrlResource) resource).getFilename();
                    return filename; // Devuelve solo el nombre del archivo
                })
                .collect(Collectors.toList());
    }







}
