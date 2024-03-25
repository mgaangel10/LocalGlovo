import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Content, ListadoComercioResponse } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-comercio-list',
  templateUrl: './comercio-list.component.html',
  styleUrl: './comercio-list.component.css'
})
export class ComercioListComponent implements OnInit {
  comercioList: Content[] = [];
  @Output() comercioClick = new EventEmitter<String>();
  constructor(private comercioSer: ComerciosService) { }

  ngOnInit(): void {
    this.comercioSer.ListadoDeComercioResponse().subscribe((response: ListadoComercioResponse) => {
      this.comercioList = response.content;
    });
  }

  comercioClickLista(id: String) {
    this.comercioClick.emit(id);
  }
}
