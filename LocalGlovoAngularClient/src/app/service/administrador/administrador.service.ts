import { HttpClient, HttpHeaders } from '@angular/common/http';
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


  LoginResponseAdministrador(email: string, password: string): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(`${environment.HeadUrl}/auth/login/admin`,
      {
        "email": `${email}`,
        "password": `${password}`
      });
  }

  getAdministrador(): Observable<AdministradorResponse> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<AdministradorResponse>(`${environment.HeadUrl}/administrador/logueado`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }

  logOutAdministrador(id: string): Observable<AdministradorResponse> {
    let token1 = localStorage.getItem('TOKEN');
    let token = localStorage.removeItem('TOKEN');
    console.log(token);
    const headers = new HttpHeaders({
      'Accept': 'application/json',
      'Authorization': `Bearer ${token1}`
    });
    return this.http.post<AdministradorResponse>(`${environment.HeadUrl}/administrador/logout/${id}`, {}, { headers: headers });
  }
}
