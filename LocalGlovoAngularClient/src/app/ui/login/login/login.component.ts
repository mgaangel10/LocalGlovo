import { Component } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { LoginResponse } from '../../../models/login-administrador';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  constructor(private loginService: AdministradorService,private router:Router){};

  profileLogin = new FormGroup({
    email: new FormControl(''), 
    password: new FormControl('') 
  })

  login() {
    console.log('Datos enviados al servidor:', this.profileLogin.value); 
  
    this.loginService.LoginResponseAdministrador(this.profileLogin.value.email!, this.profileLogin.value.password!)
      .subscribe((l: LoginResponse) => {
        localStorage.setItem('TOKEN', l.token);
        localStorage.setItem('USER_ID', l.id);
        this.router.navigate(['/home']);
       

      });
  }
}
