import { Component } from '@angular/core';
import { LoginResponse } from '../../../models/login-administrador';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { FormGroup, FormControl, ReactiveFormsModule } from '@angular/forms'; // Importa FormControl en lugar de FormGroup

@Component({
  selector: 'app-administrador',
  standalone: true,
  imports: [ ReactiveFormsModule],
  templateUrl: './administrador.component.html',
  styleUrl: './administrador.component.css'
})
export class AdministradorComponent {
 
  
}
