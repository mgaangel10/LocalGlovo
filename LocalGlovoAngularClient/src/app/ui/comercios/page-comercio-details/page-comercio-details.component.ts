import { Component, OnInit } from '@angular/core';
import { ComercioDetails, Producto } from '../../../models/comercio-details';
import { Router, ActivatedRoute } from '@angular/router';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-page-comercio-details',
  templateUrl: './page-comercio-details.component.html',
  styleUrl: './page-comercio-details.component.css'
})
export class PageComercioDetailsComponent implements OnInit {
  id!: string | null;
  comercioDetails!: ComercioDetails;
  producto: Producto[] = [];

  constructor(private comercioService: ComerciosService, private router: Router, private r: ActivatedRoute) { }


  ngOnInit(): void {
    this.id = this.r.snapshot.paramMap.get('comercioId');
    if (this.id != null) {
      this.comercioService.getComercioDetails(this.id).subscribe(r => {
        this.comercioDetails = r;
        this.producto = r.productos;
      })
    }

  }
  eliminarComercio(){
    this.comercioService.eliminarComercio(this.id!).subscribe(c=>{
      this.router.navigate(['/listado-comercios']);
    })
  }
  verIngredientes(producto: Producto) {
    this.router.navigate(['/ingredientes-details', producto.id]);
  }
  addProducto() {
    this.router.navigate(['/crear-productos',this.id]);
  }

}
