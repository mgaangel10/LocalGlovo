package com.example.LocalGlovo.files.service;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import com.example.LocalGlovo.files.exception.StorageException;
import com.example.LocalGlovo.files.utils.MediaTypeUrlResource;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StreamUtils;

import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class FicheroService {
    @Value("${storage.location}")
    private String storageLocation;
    @Autowired
    private ComercioRepo comercioRepo;
    private Path rootLocation;

    @PostConstruct

    public void init() {
        rootLocation = Paths.get(storageLocation);
        try {
            Files.createDirectories(rootLocation);
        } catch (IOException e) {
            throw new StorageException("Could not initialize storage location", e);
        }

    }


    public String store(MultipartFile file)  {
        try {
            return store(file.getBytes(), file.getOriginalFilename(), file.getContentType());
        } catch (Exception ex) {
            throw new StorageException("Error storing file: " + file.getOriginalFilename(), ex);
        }
    }
    public String storeAndReturnFilename(MultipartFile file) {
        return store(file);
    }



    public String store(byte[] file, String filename, String contentType) throws Exception {

        // Limpiamos el nombre del fichero
        String newFilename = StringUtils.cleanPath(filename);

        if (file.length == 0)
            throw new Exception("The file is empty");

        newFilename = calculateNewFilename(newFilename);

        try (InputStream inputStream = new ByteArrayInputStream(file)) {
            Files.copy(inputStream, rootLocation.resolve(newFilename),
                    StandardCopyOption.REPLACE_EXISTING
            );
        } catch(IOException ex) {
            throw new StorageException("Error storing file: " + newFilename, ex);
        }

        return newFilename;
    }

    private String calculateNewFilename(String filename) {
        String newFilename = filename;

        while(Files.exists(rootLocation.resolve(newFilename))) {
            // Tratamos de generar un nuevo
            String extension = StringUtils.getFilenameExtension(newFilename);
            String name = newFilename.replace("." + extension, "");

            String suffix = Long.toString(System.currentTimeMillis());
            suffix = suffix.substring(suffix.length()-6);

            newFilename = name + "_" + suffix + "." + extension;

        }
        return newFilename;
    }




    public List<Resource> loadAll() {
        try {
            return Files.walk(rootLocation, 1)
                    .filter(path -> !path.equals(rootLocation))
                    .map(rootLocation::relativize)
                    .map(path -> loadAsResource(path.toString()))
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new StorageException("Error reading all files", e);
        }
    }

    // En FicheroService
    public List<Resource> loadAllImages() {
        List<Comercio> comercios = comercioRepo.findAll();
        return comercios.stream()
                .map(comercio -> loadAsResource(comercio.getImagen()))
                .collect(Collectors.toList());
    }






    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }


    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            MediaTypeUrlResource resource =
                    new MediaTypeUrlResource(file.toUri());

            if (resource.exists() && resource.isReadable()) {
                return resource;
            } else {
                throw new StorageException("Could not read file: " + filename);
            }

        } catch (MalformedURLException ex) {
            throw new StorageException("Could not read file: " + filename);
        }
    }




    public void deleteFile(String filename) {
        try {
            Files.delete(load(filename));
        } catch (IOException e) {
            throw new StorageException("Could not delete file:" + filename);
        }
    }


    public void deleteAll() {
        try {
            FileSystemUtils.deleteRecursively(rootLocation);
        } catch (IOException e) {
            throw new StorageException("Could not delete all");
        }
    }
}
