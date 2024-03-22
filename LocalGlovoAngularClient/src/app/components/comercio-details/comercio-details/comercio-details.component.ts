import { Component, OnInit } from '@angular/core';
import { ComercioDetails, Ingrediente, Producto } from '../../../models/comercio-details';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-comercio-details',
  templateUrl: './comercio-details.component.html',
  styleUrl: './comercio-details.component.css'
})
export class ComercioDetailsComponent implements OnInit {
  id!: String | null;
  comercioDetails!: ComercioDetails;
  producto!: Producto;

  constructor(private comercioService: ComerciosService, private router: Router, private r: ActivatedRoute) { }


  ngOnInit(): void {
    this.id = this.r.snapshot.paramMap.get('id');
    if (this.id != null) {
      this.comercioService.getComercioDetails(this.id).subscribe(r => {
        this.comercioDetails = r;
      })
    }

  }

}
