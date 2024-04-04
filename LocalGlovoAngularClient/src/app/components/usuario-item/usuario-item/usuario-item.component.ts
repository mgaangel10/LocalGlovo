import { Component, Input, OnInit } from '@angular/core';
import { ListadoUsarios } from '../../../models/list-usuarios';
import { UsuarioService } from '../../../service/usuarios/usuario.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-usuario-item',
  templateUrl: './usuario-item.component.html',
  styleUrl: './usuario-item.component.css'
})
export class UsuarioItemComponent{


  @Input() usuarios!:ListadoUsarios;
  id!: string | null;
   constructor(private usuarioServcie:UsuarioService,private r: ActivatedRoute){}


 

  

}
