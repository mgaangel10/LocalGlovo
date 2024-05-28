import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { ComercioDetails } from '../../models/comercio-details';
import { ProductosDetails } from '../../models/productos-details';
import { environment } from '../../environments/environment';
import { AddProducto } from '../../models/add-producto';
import { AddIngredintes } from '../../models/add-ingredientes';
import { EditarProducto } from '../../models/editar-productos';

@Injectable({
  providedIn: 'root'
})
export class ProductosService {

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

  getProductosById(id: String): Observable<ProductosDetails>{
    let token = localStorage.getItem('TOKEN');
    return this.http.get<ProductosDetails>(`${environment.HeadUrl}/administrador/productos/${id}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  addPorducto(idComercio: string, imagen: string, name: string, precio: number, disponible: boolean): Observable<AddProducto> {
    let token = localStorage.getItem('TOKEN');
    return this.http.post<AddProducto>(`${environment.HeadUrl}/administrador/crear/producto/${idComercio}`, {
      imagen: `${imagen}`,
      name: `${name}`,
      precio: `${precio}`,
      disponible: `${disponible}`
    }, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    }).pipe(
      catchError(this.handleError)
    );
  }

  eliminarProducto(idProducto:string){
    let token = localStorage.getItem('TOKEN');
    return this.http.delete(`${environment.HeadUrl}/administrador/delete/producto/${idProducto}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }

  eliminarIngredientes(id:string){
    let token = localStorage.getItem('TOKEN');
    return this.http.delete(`${environment.HeadUrl}/administrador/eliminar/${id}`, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }
  addIngredintes(id:string,name:string,imagen:string):Observable<AddIngredintes>{
    let token = localStorage.getItem('TOKEN');
    return this.http.post<AddIngredintes>(`${environment.HeadUrl}/administrador/add/ingredientes/${id}`,{
      
      "name":`${name}`,
      "imagen": `${imagen}`
      
    }, {
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    })
  }

  editarProducto(idProducto:string,imagen:string,name:string,precio:number,disponible:boolean):Observable<EditarProducto>{
    let token = localStorage.getItem('TOKEN');
    return this.http.put<EditarProducto>(`${environment.HeadUrl}/administrador/editar/producto/${idProducto}`,{
      "imagen":`${imagen}`,
      "name":`${name}`,
      "precio":`${precio}`,
      "disponible":`${disponible}`,
    },{
      headers: {
        accept: 'application/json',
        'Authorization': `Bearer ${token}`
      }
    }).pipe(
      catchError(this.handleError)
    )
  }

}
