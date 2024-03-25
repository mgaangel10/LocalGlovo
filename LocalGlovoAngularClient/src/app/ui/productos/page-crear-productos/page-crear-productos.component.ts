import { Component } from '@angular/core';
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
  comercioID!:string;
  constructor(private productoService:ProductosService, private router:Router, private route: ActivatedRoute) {
    this.route.params.subscribe(params => {
      this.comercioID = params['id'];
    });
  }
  
  
  crearProducto = new FormGroup({
    imagen: new FormControl(''), 
    name: new FormControl(''),
    precio: new FormControl(),
    disponible: new FormControl()   
  })

  add() {
    console.log('Datos enviados al servidor:', this.crearProducto.value); 
  
    this.productoService.addPorducto(this.comercioID!,this.crearProducto.value.imagen!,this.crearProducto.value.name!,this.crearProducto.value.precio,this.crearProducto.value.disponible!)
      .subscribe((l: AddProducto) => {
       
        this.router.navigate(['/comercio-details',this.comercioID]);
       

      });
  }

}
