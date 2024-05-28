import { Component, OnInit } from '@angular/core';
import { MapInfoWindow, MapMarker, GoogleMap } from '@angular/google-maps';
import { ComerciosService } from '../../service/comercios/comercios.service';
import { ListadoComercioResponse, Content } from '../../models/listado-comercio-response';
import { Router } from '@angular/router';
import { ListadoComercioGoogleMaps } from '../../models/listado-comercio-googlemaps';
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
    this.comercioService.listadoComercioGoogleMaps().subscribe((response: ListadoComercioGoogleMaps[]) => {
      response.forEach(comercio => {
        const marker: ComercioMarker = {
          options: {
            position: {
              lat: comercio.latitud,
              lng: comercio.longitud
            },
            title: comercio.name,
            clickable: true, 
          },
          comercioId: comercio.id 
        };
        this.markers.push(marker);
      });
    });
  }
  

  onMarkerClick(comercioId: string): void {
    this.router.navigate(['/comercio-details', comercioId]);
  }



}
