import { Component } from '@angular/core';
import { Location } from '@angular/common';

import { ActivatedRoute, Router } from '@angular/router';
import { Producto, Ingrediente, ComercioDetails } from '../../../models/comercio-details';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ProductosService } from '../../../service/productos/productos.service';
import { ProductosDetails } from '../../../models/productos-details';

import { SafeUrl,DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'app-page-ingredientes-details',
  templateUrl: './page-ingredientes-details.component.html',
  styleUrl: './page-ingredientes-details.component.css'
})
export class PageIngredientesDetailsComponent {
  id!: string | null;
  comercioId!: string;
  comercioDetails!: ComercioDetails;
  producto!: ProductosDetails;
  ingredientes: Ingrediente[] = [];
  imagenUrl: SafeUrl = '';
  imagenIngrediente: SafeUrl[] = []; 

  constructor(private productoService: ProductosService, private sanitizer:DomSanitizer,private route: ActivatedRoute, private router: Router, private location: Location) {
    this.route.params.subscribe(params => {
      this.id = params['id'];
      this.comercioId = params['comercioId'];

    });
  }

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    if (this.id != null) {
      this.productoService.getProductosById(this.id).subscribe(p => {
        this.producto = p;
        this.ingredientes = p.ingredientes;
        this.verImagenDelProducto(this.producto.imagen);
        this.ingredientes.forEach(i => this.verImagenDelIngrediente(i.imagen)); 
      })
    }
  }
  

  eliminarProducto() {
    this.productoService.eliminarProducto(this.id!).subscribe(p => {
      this.router.navigate(['/comercio-datils', this.comercioId]);
    })
  }
  eliminarIngredientes(idIng:string) {
    this.productoService.eliminarIngredientes(idIng).subscribe(i => {
      this.id = this.route.snapshot.paramMap.get('id');
      if (this.id != null) {
        this.productoService.getProductosById(this.id).subscribe(p => {
          this.producto = p;
          this.ingredientes = p.ingredientes;
          this.verImagenDelProducto(this.producto.imagen);
          this.ingredientes.forEach(i => this.verImagenDelIngrediente(i.imagen)); 
        })
      }

    })
  }
  addIngredientes() {
    this.router.navigate(['/crear-ingredientes', this.id]);
  }


  editar() {
    this.router.navigate(['/editar-producto', this.id]);
  }

  verImagenDelProducto(imagen: string) {
    this.productoService.verImagen(imagen).subscribe(r => {
        let urlCreator = window.URL;
        this.imagenUrl = this.sanitizer.bypassSecurityTrustUrl(
            urlCreator.createObjectURL(r)
        );
    });
}
verImagenDelIngrediente(imagen: string) {
  if (imagen) { 
    this.productoService.verImagen(imagen).subscribe(r => {
      let urlCreator = window.URL;
      this.imagenIngrediente.push(this.sanitizer.bypassSecurityTrustUrl(
          urlCreator.createObjectURL(r)
      ));
    });
  } else {
    console.log('La imagen del ingrediente es null o undefined');
  }
}

}
