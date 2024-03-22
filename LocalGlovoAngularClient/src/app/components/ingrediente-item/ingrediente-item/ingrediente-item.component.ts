import { Component, Input } from '@angular/core';
import { Ingrediente } from '../../../models/comercio-details';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-ingrediente-item',
  templateUrl: './ingrediente-item.component.html',
  styleUrl: './ingrediente-item.component.css'
})
export class IngredienteItemComponent {
  @Input() ingrediente!: Ingrediente;

  constructor(private ingredienteService: ComerciosService) { }


}
