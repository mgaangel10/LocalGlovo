import { Component, OnInit } from '@angular/core';
import { MapInfoWindow, MapMarker, GoogleMap } from '@angular/google-maps';
import { ComerciosService } from '../../service/comercios/comercios.service';
import { ListadoComercioResponse, Content } from '../../models/listado-comercio-response';

@Component({
  selector: 'app-maps',
  templateUrl: './maps.component.html',
  styleUrl: './maps.component.css'
})
export class MapsComponent implements OnInit{


  mapOptions: google.maps.MapOptions = {
    center: {lat: 40.416775, lng: -3.703790}, // Coordenadas de un punto central para iniciar el mapa
    zoom: 15
  };
  markers: google.maps.MarkerOptions[] = []; // Aquí almacenaremos los marcadores para cada comercio

  constructor(private yourService: ComerciosService) { } // Inyecta tu servicio aquí

  ngOnInit(): void {
    this.loadComercios();
  }

  loadComercios(): void {
    this.yourService.ListadoDeComercioResponse(0).subscribe((response: ListadoComercioResponse) => {
      response.content.forEach((comercio: Content) => {
        const marker = {
          position: {
            lat: comercio.latitud,
            lng: comercio.longitud
          },
          title: comercio.name
        };
        this.markers.push(marker);
      });
    });
  }

}
