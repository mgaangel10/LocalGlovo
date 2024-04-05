import { Component } from '@angular/core';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { FormControl, FormGroup } from '@angular/forms';
import { AddComercio } from '../../../models/add-comercio';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-comercio-page',
  templateUrl: './add-comercio-page.component.html',
  styleUrl: './add-comercio-page.component.css'
})
export class AddComercioPageComponent {

  constructor(private comercioService:ComerciosService,private router:Router){}

  crearComercio = new FormGroup({
    name: new FormControl(''), 
    latitud: new FormControl(''),
    longitud: new FormControl(''),
    nameDirection: new FormControl(''),
    categorias: new FormControl(''),
    imagen: new FormControl('')

  })

  add(){
    this.comercioService.addComercio(this.crearComercio.value.name!,this.crearComercio.value.latitud!,this.crearComercio.value.longitud!,this.crearComercio.value.nameDirection!,this.crearComercio.value.categorias!,this.crearComercio.value.imagen!)
    .subscribe((c:AddComercio)=>{
      this.router.navigate(['/listado-comercios']);
    })
  }

}
