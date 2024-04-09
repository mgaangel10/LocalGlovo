import { Component } from '@angular/core';
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
  constructor(private productoService:ProductosService,private router:Router, private route: ActivatedRoute){
    this.route.params.subscribe(params => {
      this.id = params['id'];
      
     
    });
  }
  crearComercio = new FormGroup({

    name: new FormControl(''), 
   
    imagen: new FormControl('')

  })

  add(){
    this.productoService.addIngredintes(this.id!,this.crearComercio.value.name!,this.crearComercio.value.imagen!)
    .subscribe((c:AddIngredintes)=>{
      this.router.navigate(['/ingredientes-details', this.id]);
    })
  }

}
