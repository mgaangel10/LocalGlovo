import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LoginResponse } from '../../models/login-administrador';
import { environment } from '../../environments/environment';
import { AdministradorResponse } from '../../models/Administrador-response';

@Injectable({
  providedIn: 'root'
})
export class AdministradorService {

  constructor(private http: HttpClient) { }


  LoginResponseAdministrador(email:string,password:string): Observable<LoginResponse>{
    return this.http.post<LoginResponse>(`${environment.HeadUrl}/auth/login/admin`,
    {
      "email": `${email}`,
      "password":`${password}`
    });
  }

  getAdministrador():Observable<AdministradorResponse>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<AdministradorResponse>(`${environment.HeadUrl}/administrador/logueado`,{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
}
