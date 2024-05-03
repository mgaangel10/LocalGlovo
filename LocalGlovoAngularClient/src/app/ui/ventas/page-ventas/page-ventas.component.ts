import { Component, OnInit } from '@angular/core';
import { VentasResponse } from '../../../models/ventas-response';
import { AdministradorService } from '../../../service/administrador/administrador.service';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-page-ventas',
  templateUrl: './page-ventas.component.html',
  styleUrl: './page-ventas.component.css'
})
export class PageVentasComponent implements OnInit {

  ventas!: VentasResponse;

  constructor(private adminService: AdministradorService) { }

  ngOnInit(): void {

  }
  viewVentas = new FormGroup({
    fecha: new FormControl()
  })

  verVentas() {
    this.adminService.verVentas(this.viewVentas.value.fecha).subscribe(v => {
      this.ventas = v;
    })
  }
}
