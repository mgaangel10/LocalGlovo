import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { ListadoComercioResponse } from '../../models/listado-comercio-response';
import { environment } from '../../environments/environment';
import { ComercioDetails } from '../../models/comercio-details';
import { AddComercio } from '../../models/add-comercio';
import { ListadoComercioGoogleMaps } from '../../models/listado-comercio-googlemaps';
import { ListadoComerciosFiltrados } from '../../models/listado-filtrado';
import { EditarComercioREsponse } from '../../models/editar-comercio';

@Injectable({
  providedIn: 'root'
})
export class ComerciosService {

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

  ListadoDeComercioResponse(pagina: number): Observable<ListadoComercioResponse> {
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioResponse>(`${environment.HeadUrl}/administrador/listar/comercios?page=${pagina}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });
  }
  listadoComercioGoogleMaps():Observable<ListadoComercioGoogleMaps[]>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComercioGoogleMaps[]>(`${environment.HeadUrl}/administrador/listado/googlemaps`,{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
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
  getComercioByNombre(nombre:string): Observable<ComercioDetails>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ComercioDetails>(`${environment.HeadUrl}/administrador/buscar/comercio/${nombre}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  addComercio(name: string, latitud: string, longitud: string, nameDirection: string, categorias: string, imagen: File): Observable<AddComercio> {
    let token = localStorage.getItem('TOKEN');

    
    let formData = new FormData();
    formData.append('comercio', JSON.stringify({
      "name": name,
      "latitud": latitud,
      "longitud": longitud,
      "nameDirection": nameDirection,
      "categorias": categorias
    }));
    formData.append('file', imagen); 

    return this.http.post<AddComercio>(`${environment.HeadUrl}/administrador/crear/comercio`, formData, {
        headers: {
            accept: 'application/json',
            'Authorization': `Bearer ${token}`
        }
    }).pipe(
        catchError(this.handleError)
    );
}

editarComercio(idComercio:string,name: string, latitud: string, longitud: string, nameDirection: string, categorias: string, imagen: File): Observable<EditarComercioREsponse> {
  let token = localStorage.getItem('TOKEN');

  
  let formData = new FormData();
  formData.append('comercio', JSON.stringify({
    "name": name,
    "latitud": latitud,
    "longitud": longitud,
    "nameDirection": nameDirection,
    "categorias": categorias
  }));
  formData.append('file', imagen); 

  return this.http.put<EditarComercioREsponse>(`${environment.HeadUrl}/administrador/editar/comercio/${idComercio}`, formData, {
      headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${token}`
      }
  }).pipe(
      catchError(this.handleError)
  );
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
  listadoCategorias():Observable<string[]>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<string[]>(`${environment.HeadUrl}/administrador/listado/categorias`,{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  filtrarPorCategoria(categoria:string):Observable<ListadoComerciosFiltrados[]>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ListadoComerciosFiltrados[]>(`${environment.HeadUrl}/administrador/filtrar/comercios/${categoria}`,{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  verImagen(fileName: string): Observable<Blob> {
    let token = localStorage.getItem('TOKEN');
    let url = `${environment.HeadUrl}/administrador/download/${fileName}`;
    return this.http.get(url, { responseType: 'blob', headers: { 'Authorization': `Bearer ${token}` } });
}
obtenerTodasLasImagenes(): Observable<string[]> {
  let token = localStorage.getItem('TOKEN');
  let url = `${environment.HeadUrl}/administrador/all/files`;
  return this.http.get<string[]>(url, { headers: { 'Authorization': `Bearer ${token}` } });
}





}
