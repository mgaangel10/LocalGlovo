import { Component, ElementRef, ViewChild } from '@angular/core';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { FormControl, FormGroup } from '@angular/forms';
import { AddComercio } from '../../../models/add-comercio';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-comercio-page',
  templateUrl: './add-comercio-page.component.html',
  styleUrl: './add-comercio-page.component.css'
})
export class AddComercioPageComponent {
  errorMessage: string = '';
  categorias: string[] = [];
  mapOptions: google.maps.MapOptions = {
    center: { lat: 37.267892259937966, lng: -6.062729833230927 },
    zoom: 15
  };

  crearComercio = new FormGroup({
    name: new FormControl(''),
    latitud: new FormControl(''),
    longitud: new FormControl(''),
    nameDirection: new FormControl(''),
    categorias: new FormControl(''),
    imagen: new FormControl('')
  });

  constructor(private comercioService: ComerciosService, private router: Router) {
    this.imagen = new ElementRef<HTMLInputElement>(document.createElement('input'));
  }


  ngOnInit(): void {
    this.listadoCategorias();
  }

  marker: google.maps.Marker | null = null;
  map: google.maps.Map | null = null;

  onMapInit(map: google.maps.Map): void {
    this.map = map;
  }
  onMapClick(event: google.maps.MapMouseEvent): void {

    if (event.latLng) {
      const lat = event.latLng.lat();
      const lng = event.latLng.lng();

      this.crearComercio.controls['latitud'].setValue(lat.toString());
      this.crearComercio.controls['longitud'].setValue(lng.toString());
    }
  }




  // Obtener una referencia al campo de entrada de archivos
  @ViewChild('imagen') imagen: ElementRef;

  add(): void {
    // Obtener el archivo del campo de entrada de archivos
    let imagenFile = this.imagen.nativeElement.files[0];

    this.comercioService.addComercio(
      this.crearComercio.value.name!,
      this.crearComercio.value.latitud!,
      this.crearComercio.value.longitud!,
      this.crearComercio.value.nameDirection!,
      this.crearComercio.value.categorias!,
      imagenFile // Pasar el archivo de la imagen a tu servicio
    ).subscribe({
      next: (c: AddComercio) => {
        this.router.navigate(['/listado-comercios']);
        console.log(c);
      }, error: (err) => {
        this.errorMessage = err;
      }
    });
  }

  listadoCategorias() {
    this.comercioService.listadoCategorias().subscribe(c => {
      this.categorias = c;

    })
  }

}
