import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ListadoUsarios } from '../../models/list-usuarios';
import { environment } from '../../environments/environment';
import { Observable } from 'rxjs';
import { QuitarCuentaUsuario } from '../../models/quitar-cuenta-usuario';
import { LoginResponse } from '../../models/login-administrador';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  constructor(private http: HttpClient) { }
  
  getUsuarios(): Observable<ListadoUsarios[]> {
    
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoUsarios[]>(`${environment.HeadUrl}/administrador/ver/usuarios`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }

  eliminarUsuario(id:string): Observable<QuitarCuentaUsuario> {
    let token = localStorage.getItem('TOKEN');
    console.log(token);
    const headers = new HttpHeaders({
      'Accept': 'application/json',
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<QuitarCuentaUsuario>(`${environment.HeadUrl}/administrador/quitar/cuenta/usuario/${id}`, {}, { headers: headers });
  }
  
}
