import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Content } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ComercioDetails } from '../../../models/comercio-details';

@Component({
  selector: 'app-comercio-item',
  templateUrl: './comercio-item.component.html',
  styleUrl: './comercio-item.component.css'
})
export class ComercioItemComponent {
  @Input() comercio!: Content;
  @Output() comercioClick = new EventEmitter<String>();

  constructor(private comercioService: ComerciosService) { }

  comercioDetails!: ComercioDetails;

  ngOnInit(): void {
    this.getComercioDetails(this.comercio.id);
  }

  getComercioDetails(id: String): void {
    this.comercioService.getComercioDetails(id).subscribe(d => {
      this.comercioDetails = d;

    })
  }



}
