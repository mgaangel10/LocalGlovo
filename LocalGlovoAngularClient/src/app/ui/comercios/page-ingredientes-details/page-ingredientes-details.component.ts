import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
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
  id!: String | null;
  comercioDetails!: ComercioDetails;
  producto!: ProductosDetails;
  ingredientes: Ingrediente []=[];

  constructor(private productoService: ProductosService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.id = this.route.snapshot.paramMap.get('id');
    if (this.id != null) {
     this.productoService.getProductosById(this.id).subscribe(p=>{
      this.producto = p;
      this.ingredientes = p.ingredientes;
     })
    }
  }
}
