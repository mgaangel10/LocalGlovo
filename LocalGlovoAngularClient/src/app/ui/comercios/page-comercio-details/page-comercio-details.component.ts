import { Component, OnInit } from '@angular/core';
import { ComercioDetails, Producto } from '../../../models/comercio-details';
import { Router, ActivatedRoute } from '@angular/router';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { SafeUrl,DomSanitizer } from '@angular/platform-browser';
import { ProductosService } from '../../../service/productos/productos.service';
import { ProductosDetails } from '../../../models/productos-details';

@Component({
  selector: 'app-page-comercio-details',
  templateUrl: './page-comercio-details.component.html',
  styleUrl: './page-comercio-details.component.css'
})
export class PageComercioDetailsComponent implements OnInit {
  id!: string | null;
  comercioId!: string | null;
  comercioDetails!: ComercioDetails;
  producto: Producto[] = [];
  imagenUrl: SafeUrl = '';
  imagenProducto: SafeUrl[] = [];
  

  constructor(private comercioService: ComerciosService, private router: Router, private r: ActivatedRoute,private sanitizer:DomSanitizer,private productoService:ProductosService,private route: ActivatedRoute) {
    this.route.params.subscribe(params => {
      
      this.comercioId = params['comercioId'];

    });
   }


  ngOnInit(): void {
    this.comercioId = this.r.snapshot.paramMap.get('comercioId');
    if (this.comercioId != null) {
      this.comercioService.getComercioDetails(this.comercioId).subscribe(r => {
        this.comercioDetails = r;
        this.producto = r.productos;
        this.verImagenDelComercio(this.comercioDetails.imagen);
        this.producto.forEach(p => this.verImagenDelProducto(p.imagen));
      })
    }

  }

  verImagenDelComercio(imagen: string) {
    this.comercioService.verImagen(imagen).subscribe(r => {
        let urlCreator = window.URL;
        this.imagenUrl = this.sanitizer.bypassSecurityTrustUrl(
            urlCreator.createObjectURL(r)
        );
    });
}

verImagenDelProducto(imagen: string) {
  this.comercioService.verImagen(imagen).subscribe(r => {
      let urlCreator = window.URL;
      this.imagenProducto.push(this.sanitizer.bypassSecurityTrustUrl(
          urlCreator.createObjectURL(r)
      ));
  });
}

  eliminarComercio(){
    this.comercioService.eliminarComercio(this.comercioId!).subscribe(c=>{
      this.router.navigate(['/listado-comercios']);
    })
  }
  editarComercio(idComercio:string){
    this.router.navigate(['/editar-comercio', idComercio]);
  }
  
  verIngredientes(producto: Producto) {
    this.router.navigate(['/ingredientes-details', producto.id]);
  }
  addProducto() {
    this.router.navigate(['/crear-productos',this.comercioId]);
  }

  editarproducto(id:string){
    this.router.navigate(['/editar-producto', id]);
  }

}
