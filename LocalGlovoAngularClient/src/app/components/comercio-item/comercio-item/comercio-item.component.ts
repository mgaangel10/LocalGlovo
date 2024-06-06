import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Content } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ComercioDetails } from '../../../models/comercio-details';
import { SafeUrl,DomSanitizer } from '@angular/platform-browser';
import { Router } from '@angular/router';

@Component({
  selector: 'app-comercio-item',
  templateUrl: './comercio-item.component.html',
  styleUrl: './comercio-item.component.css'
})
export class ComercioItemComponent {
  @Input() comercio!: Content;
  @Output() comercioClick = new EventEmitter<String>();
  imagenUrl: SafeUrl = '';
  
  constructor(private comercioService: ComerciosService,private sanitizer:DomSanitizer,private router: Router) { }

  comercioDetails!: ComercioDetails;

  ngOnInit(): void {
    this.getComercioDetails(this.comercio.id);
    this.verImagenDelComercio(this.comercioDetails.imagen);
  }

  getComercioDetails(id: String): void {
    this.comercioService.getComercioDetails(id).subscribe(d => {
      this.comercioDetails = d;
      this.verImagenDelComercio(this.comercioDetails.imagen);

    })
  }
  

  verImagenDelComercio(imagen: string) {
    this.comercioService.verImagen(imagen).subscribe(r => {
        let urlCreator = window.URL;
        console.log(this.imagenUrl);
        this.imagenUrl = this.sanitizer.bypassSecurityTrustUrl(
            urlCreator.createObjectURL(r)
            
        );
        
    });
}

editarComercio(id:string){
  this.router.navigate(['/editar-comercio', id]);
}


  


}
