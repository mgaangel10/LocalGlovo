import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { LoginResponse } from '../../models/login-administrador';
import { environment } from '../../environments/environment';
import { AdministradorResponse } from '../../models/Administrador-response';
import { VentasResponse } from '../../models/ventas-response';
import { ListadoComercioSinPaginar } from '../../models/listado-comercio-sin-paginar';
import { AddAdministrador } from '../../models/add-administrador';

@Injectable({
  providedIn: 'root'
})
export class AdministradorService {

  constructor(private http: HttpClient) { }

  private handleError(error: HttpErrorResponse) {
    let errorMessage = 'An unknown error occurred!';
    if (error.error instanceof ErrorEvent) {
      
      errorMessage = `Error: ${error.error.message}`;
    } else {
      
      if (error.error && error.error.message) {
        errorMessage = `Error: ${error.error.message}`;
      } else {
        errorMessage = `Server returned code: ${error.status}, error message is: ${error.message}`;
      }
    }
    return throwError(errorMessage);
  }


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

  verVentas(fecha: Date): Observable<VentasResponse> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<VentasResponse>(`${environment.HeadUrl}/administrador/ver/ventas/${fecha}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    }).pipe(
      catchError(this.handleError)
  );
  }

  comercioConMasLikes(): Observable<ListadoComercioSinPaginar[]> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioSinPaginar[]>(`${environment.HeadUrl}/administrador/ver/comercios/mayor/likes`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }


  AddAdministrador(email:string,fotoUrl: File,name:string,lastName:string, ): Observable<AddAdministrador> {
    

    
    let formData = new FormData();
    formData.append('admin', JSON.stringify({
     "email":`${email}`,
     "name":`${name}`,
     "lastName":`${lastName}`,
     
    }));
    formData.append('file', fotoUrl); 

    return this.http.post<AddAdministrador>(`${environment.HeadUrl}/auth/register/admin`, formData).pipe(
        catchError(this.handleError)
    );
}
}
