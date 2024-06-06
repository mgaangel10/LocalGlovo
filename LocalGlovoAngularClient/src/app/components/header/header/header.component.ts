import { Component, OnInit } from '@angular/core';
import { LoginResponse } from '../../../models/login-administrador';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { AdministradorResponse } from '../../../models/Administrador-response';
import { Router } from '@angular/router';
import { ProductosService } from '../../../service/productos/productos.service';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { DomSanitizer, SafeUrl } from '@angular/platform-browser';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent implements OnInit {
  imagenUrl: SafeUrl = '';
  administrador!: AdministradorResponse;
  constructor(private admin: AdministradorService, private router: Router,private comercioService:ComerciosService,private sanitizer:DomSanitizer) { }

  ngOnInit(): void {
    this.admin.getAdministrador().subscribe(a => {
      this.administrador = a;
      this.verImagenDelComercio(this.administrador.fotoUrl);
    })

  }

  logout() {
    this.admin.logOutAdministrador(this.administrador.id).subscribe(ad => {
      this.administrador = ad;
      this.router.navigate(['/']);
    })
  }

  verImagenDelComercio(imagen: string) {
    this.comercioService.verImagen(imagen).subscribe(r => {
        let urlCreator = window.URL;
        this.imagenUrl = this.sanitizer.bypassSecurityTrustUrl(
            urlCreator.createObjectURL(r)
        );
    });
}

}
