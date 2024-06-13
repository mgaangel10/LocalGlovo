import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { AddComercio } from '../../../models/add-comercio';
import { ProductosService } from '../../../service/productos/productos.service';
import { ActivatedRoute, Router } from '@angular/router';
import { AddIngredintes } from '../../../models/add-ingredientes';

@Component({
  selector: 'app-add-ingredientes-page',
  templateUrl: './add-ingredientes-page.component.html',
  styleUrl: './add-ingredientes-page.component.css'
})
export class AddIngredientesPageComponent {
  id!: string | null;
  errorMessage: string = '';
  constructor(private productoService:ProductosService,private router:Router, private route: ActivatedRoute){
    this.route.params.subscribe(params => {
      this.id = params['id'];
      
     
    });
    this.imagen = new ElementRef<HTMLInputElement>(document.createElement('input'));
  }
  crearComercio = new FormGroup({

    name: new FormControl(''), 
   
    imagen: new FormControl('')

  })

   
@ViewChild('imagen') imagen: ElementRef;

add(): void {

  let imagenFile = this.imagen.nativeElement.files[0];

  this.productoService.addIngredintes(
    this.id!,
    this.crearComercio.value.name!,
    imagenFile, 
    
    
    
  ).subscribe({
    next: (p: AddIngredintes) => {
      this.router.navigate(['/ingredientes-details', this.id]);
    }, error: (err) => {
      this.errorMessage = err;
    }
  });
}

}
