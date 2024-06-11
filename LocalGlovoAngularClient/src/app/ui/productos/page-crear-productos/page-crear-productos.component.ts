import { Component, ElementRef, ViewChild } from '@angular/core';
import { ProductosService } from '../../../service/productos/productos.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormGroup, FormControl } from '@angular/forms';
import { ComercioDetails } from '../../../models/comercio-details';
import { AddProducto } from '../../../models/add-producto';

@Component({
  selector: 'app-page-crear-productos',
  templateUrl: './page-crear-productos.component.html',
  styleUrl: './page-crear-productos.component.css'
})
export class PageCrearProductosComponent {
  comercioID!: string;
  errorMessage: string = '';

  constructor(private productoService: ProductosService, private router: Router, private route: ActivatedRoute) {
    this.route.params.subscribe(params => {
      this.comercioID = params['id'];
      
    });
    this.imagen = new ElementRef<HTMLInputElement>(document.createElement('input'));
  }

  crearProducto = new FormGroup({
    imagen: new FormControl(''), 
    name: new FormControl(''),
    precio: new FormControl(),
    disponible: new FormControl()   
  });

 
@ViewChild('imagen') imagen: ElementRef;

add(): void {
  
  let imagenFile = this.imagen.nativeElement.files[0];

  this.productoService.addProducto(
    this.comercioID!,
    imagenFile, 
    this.crearProducto.value.name!,
    this.crearProducto.value.precio!,
    this.crearProducto.value.disponible!
  ).subscribe({
    next: (p: AddProducto) => {
      this.router.navigate(['/comercio-details', this.comercioID]);
    }, error: (err) => {
      this.errorMessage = err;
    }
  });
}

}

  


