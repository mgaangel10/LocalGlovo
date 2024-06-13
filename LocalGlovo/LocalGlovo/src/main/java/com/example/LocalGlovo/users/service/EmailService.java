package com.example.LocalGlovo.users.service;

import com.example.LocalGlovo.users.model.Administrador;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;



    public void registroAdmin(Administrador user, String contra) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject("Registro exitoso!");
        mailMessage.setText("Para iniciar sesion como Administrador copie esta contraseña. Esta es tu contraseña:"+contra);

        mailSender.send(mailMessage);
    }
}
