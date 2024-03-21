import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ListadoComercioResponse } from '../../models/listado-comercio-response';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ComerciosService {

  constructor(private http: HttpClient) { }

  ListadoDeComercioResponse():Observable<ListadoComercioResponse>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioResponse>(`${environment.HeadUrl}/administrador/listar/comercios`,{
      headers:{
        accept:'application/json',
        'Authorization':`Bearer ${token}`
        }
      } )
  }


}
