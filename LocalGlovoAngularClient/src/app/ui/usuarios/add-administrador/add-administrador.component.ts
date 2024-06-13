import { Component, ElementRef, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { AddAdministrador } from '../../../models/add-administrador';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-administrador',
  templateUrl: './add-administrador.component.html',
  styleUrl: './add-administrador.component.css'
})
export class AddAdministradorComponent {

  errorMessage: string = '';
  constructor(private admin:AdministradorService,private router: Router){
    this.imagen = new ElementRef<HTMLInputElement>(document.createElement('input'));
  }
  profileLogin = new FormGroup({
    email: new FormControl(''), 
    fotoUrl: new FormControl(''),
    name: new FormControl(''),
    lastName: new FormControl('')
    
  })


  
@ViewChild('fotoUrl') imagen: ElementRef;

add(): void {
    
    let imagenFile = this.imagen.nativeElement.files[0];

    this.admin.AddAdministrador(
        this.profileLogin.value.email!,
        imagenFile,
        this.profileLogin.value.name!,
        this.profileLogin.value.lastName!,
        
      
        
    ).subscribe({
        next: (c: AddAdministrador) => {
            this.router.navigate(['/listado-comercios']);
        }, error: (err) => {
            this.errorMessage = err;
        }
    });
}


}
