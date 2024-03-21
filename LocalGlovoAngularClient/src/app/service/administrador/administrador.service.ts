import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { LoginResponse } from '../../models/login-administrador';
import { environment } from '../../environments/environment';

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
}
