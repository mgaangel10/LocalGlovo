import { Component, OnInit } from '@angular/core';
import { LoginResponse } from '../../../models/login-administrador';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { AdministradorResponse } from '../../../models/Administrador-response';
import { Router } from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent implements OnInit {

  administrador!: AdministradorResponse;
  constructor(private admin: AdministradorService, private router: Router) { }

  ngOnInit(): void {
    this.admin.getAdministrador().subscribe(a => {
      this.administrador = a;
    })

  }

  logout() {
    this.admin.logOutAdministrador(this.administrador.id).subscribe(ad => {
      this.administrador = ad;
      this.router.navigate(['/']);
    })
  }


}
