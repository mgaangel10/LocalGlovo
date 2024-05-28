import { Component, OnInit } from '@angular/core';
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

  add() {
    console.log('Datos enviados al servidor:', this.editarProducto.value); 
  
    this.productoService.editarProducto(this.producto!,this.editarProducto.value.imagen!,this.editarProducto.value.name!,this.editarProducto.value.precio,this.editarProducto.value.disponible!)
      .subscribe({
       next: (l: EditarProducto) => {
       
        this.router.navigate(['/ingredientes-details',this.producto]);
       

      },
    error:(err)=>{
      this.errorMessage = err;
    }});
  }

 
}
