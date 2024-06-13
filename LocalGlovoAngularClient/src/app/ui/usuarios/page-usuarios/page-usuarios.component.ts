import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { ListadoUsarios } from '../../../models/list-usuarios';
import { UsuarioService } from '../../../service/usuarios/usuario.service';
import { ActivatedRoute, Router } from '@angular/router';
import { QuitarCuentaUsuario } from '../../../models/quitar-cuenta-usuario';

@Component({
  selector: 'app-page-usuarios',
  templateUrl: './page-usuarios.component.html',
  styleUrl: './page-usuarios.component.css'
})
export class PageUsuariosComponent implements OnInit {
  usuario: ListadoUsarios[] = [];
  resultados: any[] = [];
  us!: QuitarCuentaUsuario;
  id!: string | null;
  searchTerm: string = '';
  constructor(private usuarioServcie: UsuarioService, private router: Router, private r: ActivatedRoute, private cdr: ChangeDetectorRef) { }


  ngOnInit(): void {
    this.id = this.r.snapshot.paramMap.get('usuarioId');
    this.cargarUsuarios();
  }

  eliminarUsuario(id:string) {
    this.usuarioServcie.eliminarUsuario(id).subscribe(u => {
      
    this.cargarUsuarios()
    })

  }


  cargarUsuarios() {
    this.usuarioServcie.getUsuarios().subscribe((u: ListadoUsarios[]) => {
      this.usuario = u;
      this.resultados = [...this.usuario];
    })
  }

  buscarUsuario(buscar: string) {
    this.usuarioServcie.buscarUsuario(buscar).subscribe((r: any) => {
      console.log(r); 
      if (Array.isArray(r)) {
        this.resultados = r;
      } else {
        this.resultados = [r];
      }
      this.cdr.detectChanges();
    })
    
  }

  onKeyUp(event: any) {
    this.searchTerm = event?.target?.value;
    if (this.searchTerm) {
      this.buscarUsuario(this.searchTerm);
    } else {
      this.resultados = [...this.usuario];
    }
  }
}
