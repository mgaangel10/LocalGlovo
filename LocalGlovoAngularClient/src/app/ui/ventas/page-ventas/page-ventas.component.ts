import { Component, OnInit } from '@angular/core';
import { Producto, Usuario, VentasResponse } from '../../../models/ventas-response';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { FormControl, FormGroup } from '@angular/forms';
import { ListadoComercioSinPaginar } from '../../../models/listado-comercio-sin-paginar';
import { DomSanitizer, SafeUrl } from '@angular/platform-browser';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-page-ventas',
  templateUrl: './page-ventas.component.html',
  styleUrl: './page-ventas.component.css'
})
export class PageVentasComponent  {

  ventas!: VentasResponse;
  productos: Producto[] = []
  usuarios: Usuario[] = [];
  imagenComercio: SafeUrl[] = [];

  comercio: ListadoComercioSinPaginar[] = [];
  constructor(private adminService: AdministradorService,private comercioser: ComerciosService,private sanitizer:DomSanitizer) { }

 
  viewVentas = new FormGroup({
    fecha: new FormControl()
  })

  verImagenDelComercio(imagen: string) {
    if (imagen) { 
      this.comercioser.verImagen(imagen).subscribe(r => {
        let urlCreator = window.URL;
        this.imagenComercio.push(this.sanitizer.bypassSecurityTrustUrl(
            urlCreator.createObjectURL(r)
        ));
      });
    } else {
      
    }
  }
  

  verVentas() {
    this.adminService.verVentas(this.viewVentas.value.fecha).subscribe(v => {
      this.ventas = v;
      this.productos = v.productos;
      this.usuarios = v.usuarios;
    })
    this.adminService.comercioConMasLikes().subscribe(c => {
      this.comercio = c;
      this.comercio.forEach(comercio => this.verImagenDelComercio(comercio.imagen));
    });
    
  }
}
