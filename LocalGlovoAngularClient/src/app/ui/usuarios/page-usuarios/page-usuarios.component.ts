import { Component, OnInit } from '@angular/core';
import { ListadoUsarios } from '../../../models/list-usuarios';
import { UsuarioService } from '../../../service/usuarios/usuario.service';
import { ActivatedRoute, Router } from '@angular/router';
import { QuitarCuentaUsuario } from '../../../models/quitar-cuenta-usuario';

@Component({
  selector: 'app-page-usuarios',
  templateUrl: './page-usuarios.component.html',
  styleUrl: './page-usuarios.component.css'
})
export class PageUsuariosComponent implements OnInit{
  usuario:ListadoUsarios[] = [];
  us!:QuitarCuentaUsuario;
  id!: string | null;
   constructor(private usuarioServcie:UsuarioService,private router: Router,private r: ActivatedRoute){}


  ngOnInit(): void {
    this.id = this.r.snapshot.paramMap.get('usuarioId');
   this.usuarioServcie.getUsuarios().subscribe(response=>{
    this.usuario = response;
   }) 
  }

  eliminarUsuario() {
    this.usuarioServcie.eliminarUsuario(this.usuario[0].id!).subscribe(u=>{
      this.us = u;
      this.router.navigate(['/usuarios']);
      location.reload();
    })
    
  }
}
