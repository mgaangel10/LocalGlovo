import { Component,OnInit } from '@angular/core';
import { Content, ListadoComercioResponse } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-comercio-list',
  templateUrl: './comercio-list.component.html',
  styleUrl: './comercio-list.component.css'
})
export class ComercioListComponent implements OnInit {
  comercioList: Content[] = [];
  constructor (private comercioSer:ComerciosService){}

  ngOnInit(): void {
    this.comercioSer.ListadoDeComercioResponse().subscribe((response: ListadoComercioResponse) => {
      this.comercioList = response.content;
    });
  }
}
