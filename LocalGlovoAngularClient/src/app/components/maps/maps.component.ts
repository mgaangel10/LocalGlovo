import { Component, OnInit } from '@angular/core';
import { MapInfoWindow, MapMarker, GoogleMap } from '@angular/google-maps';
import { ComerciosService } from '../../service/comercios/comercios.service';
import { ListadoComercioResponse, Content } from '../../models/listado-comercio-response';
import { Router } from '@angular/router';
interface ComercioMarker {
  options: google.maps.MarkerOptions;
  comercioId: string;
}
@Component({
  selector: 'app-maps',
  templateUrl: './maps.component.html',
  styleUrl: './maps.component.css'
})
export class MapsComponent implements OnInit {

  
  mapOptions: google.maps.MapOptions = {
    center: { lat: 37.267892259937966, lng: -6.062729833230927 },
    zoom: 15
  };
  markers: ComercioMarker[] = [];

  constructor(private comercioService: ComerciosService, private router: Router) { }

  ngOnInit(): void {
    this.loadComercios();
  }

  loadComercios(): void {
    this.comercioService.ListadoDeComercioResponse(0).subscribe((response: ListadoComercioResponse) => {
      response.content.forEach((comercio: Content) => {
        const marker: ComercioMarker = {
          options: {
            position: {
              lat: comercio.latitud,
              lng: comercio.longitud
            },
            title: comercio.name,
            clickable: true, // Hacer el marcador clickeable
          },
          comercioId: comercio.id // Añadir el id del comercio al marcador para usarlo luego
        };
        this.markers.push(marker);
      });
    });
  }

  onMarkerClick(comercioId: string): void {
    this.router.navigate(['/comercio-details', comercioId]);
  }



}
