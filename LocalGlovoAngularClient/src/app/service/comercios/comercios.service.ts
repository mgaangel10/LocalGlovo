import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ListadoComercioResponse } from '../../models/listado-comercio-response';
import { environment } from '../../environments/environment';
import { ComercioDetails } from '../../models/comercio-details';
import { AddComercio } from '../../models/add-comercio';

@Injectable({
  providedIn: 'root'
})
export class ComerciosService {

  constructor(private http: HttpClient) { }

  ListadoDeComercioResponse(pagina: number): Observable<ListadoComercioResponse> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioResponse>(`${environment.HeadUrl}/administrador/listar/comercios?page=${pagina}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });
  }
  

  getComercioDetails(id: String): Observable<ComercioDetails> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ComercioDetails>(`${environment.HeadUrl}/administrador/buscar/id/${id}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  getComercioByNombre(nombre:string): Observable<ListadoComercioResponse>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioResponse>(`${environment.HeadUrl}/administrador/buscar/comercio/${nombre}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  addComercio(name:string,latitud:string,longitud:string,nameDirection:string,categorias:string,imagen:string):Observable<AddComercio>{
    let token = localStorage.getItem('TOKEN');
    return this.http.post<AddComercio>(`${environment.HeadUrl}/administrador/crear/comercio`,{
      "name": `${name}`,
      "latitud": `${latitud}`,
      "longitud": `${longitud}`,
      "nameDirection": `${nameDirection}`,
      "categorias": `${categorias}`,
      "imagen": `${imagen}`
    },{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }

  eliminarComercio(id:string){
    let token = localStorage.getItem('TOKEN');
    return this.http.delete(`${environment.HeadUrl}/administrador/eliminar/comercio/${id}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }



}
