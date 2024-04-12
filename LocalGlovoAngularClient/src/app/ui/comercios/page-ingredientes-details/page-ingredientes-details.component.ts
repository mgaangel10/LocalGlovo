import { Component} from '@angular/core';
import { Location } from '@angular/common';

import { ActivatedRoute, Router } from '@angular/router';
import { Producto, Ingrediente, ComercioDetails } from '../../../models/comercio-details';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ProductosService } from '../../../service/productos/productos.service';
import { ProductosDetails } from '../../../models/productos-details';

@Component({
  selector: 'app-page-ingredientes-details',
  templateUrl: './page-ingredientes-details.component.html',
  styleUrl: './page-ingredientes-details.component.css'
})
export class PageIngredientesDetailsComponent {
  id!: string | null;
  comercioId!:string;
  comercioDetails!: ComercioDetails;
  producto!: ProductosDetails;
  ingredientes: Ingrediente []=[];

  constructor(private productoService: ProductosService, private route: ActivatedRoute, private router: Router,private location:Location) {
    this.route.params.subscribe(params => {
      this.id = params['id'];
      this.comercioId = params['comercioId'];
     
    });
   }

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    if (this.id != null) {
     this.productoService.getProductosById(this.id).subscribe(p=>{
      this.producto = p;
      this.ingredientes = p.ingredientes;
     })
    }
  }

  eliminarProducto(){
    this.productoService.eliminarProducto(this.id!).subscribe(p=>{
      this.location.back();
    })
  }
  eliminarIngredientes(){
    this.productoService.eliminarIngredientes(this.producto .ingredientes[0].id!).subscribe(i=>{
      this.router.navigate(['/ingredientes-details',this.id]);
      
    })
  }
  addIngredientes(){
    this.router.navigate(['/crear-ingredientes',this.id]);
  }
  

  editar(){
    this.router.navigate(['/editar-producto',this.id]);
  }
}
