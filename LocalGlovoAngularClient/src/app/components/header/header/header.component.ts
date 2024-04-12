import { Component, OnInit } from '@angular/core';
import { LoginResponse } from '../../../models/login-administrador';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { AdministradorResponse } from '../../../models/Administrador-response';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent implements OnInit{

  administrador!:AdministradorResponse;
constructor(private admin: AdministradorService){}

  ngOnInit(): void {
    this.admin.getAdministrador().subscribe(a=>{
      this.administrador = a;
    })
  }


}
