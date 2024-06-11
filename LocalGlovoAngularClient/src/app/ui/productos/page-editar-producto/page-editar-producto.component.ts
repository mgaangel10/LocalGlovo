import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { AddProducto } from '../../../models/add-producto';
import { ProductosService } from '../../../service/productos/productos.service';
import { EditarProducto } from '../../../models/editar-productos';
import { ProductosDetails } from '../../../models/productos-details';

@Component({
  selector: 'app-page-editar-producto',
  templateUrl: './page-editar-producto.component.html',
  styleUrl: './page-editar-producto.component.css'
})
export class PageEditarProductoComponent implements OnInit{
  producto!:string;
  p!:ProductosDetails;
  errorMessage: string = '';
  constructor(private productoService:ProductosService, private router:Router, private route: ActivatedRoute) {
    this.route.params.subscribe(params => {
      this.producto = params['id'];
    });
    this.imagen = new ElementRef<HTMLInputElement>(document.createElement('input'));
  }
  
  ngOnInit() {
    this.productoService.getProductosById(this.producto).subscribe(producto => {
      this.p = producto;
    });
  }
  
  
  
  editarProducto = new FormGroup({
    imagen: new FormControl(''), 
    name: new FormControl(''),
    precio: new FormControl(),
    disponible: new FormControl()   
  })
  @ViewChild('imagen') imagen: ElementRef;
  add(): void {
  
    let imagenFile = this.imagen.nativeElement.files[0];
  
    this.productoService.editarProducto(
      this.producto,
      imagenFile, 
      this.editarProducto.value.name!,
      this.editarProducto.value.precio!,
      this.editarProducto.value.disponible!
    ).subscribe({
      next: (p: EditarProducto) => {
        this.router.navigate(['/ingredientes-details', this.producto]);
      }, error: (err) => {
        this.errorMessage = err;
      }
    });
  }

 
}
