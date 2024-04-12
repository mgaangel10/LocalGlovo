import { Component, OnInit } from '@angular/core';
import { MapInfoWindow, MapMarker, GoogleMap } from '@angular/google-maps';
import { ComerciosService } from '../../service/comercios/comercios.service';
import { ListadoComercioResponse, Content } from '../../models/listado-comercio-response';

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
  markers: google.maps.MarkerOptions[] = [];

  constructor(private yourService: ComerciosService) { }

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
