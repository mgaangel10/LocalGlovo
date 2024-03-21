import { Component,OnInit,Input,Output,EventEmitter  } from '@angular/core';
import { Content } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';

@Component({
  selector: 'app-comercio-item',
  templateUrl: './comercio-item.component.html',
  styleUrl: './comercio-item.component.css'
})
export class ComercioItemComponent {
  @Input() comercio!: Content;
  @Output() comercioClick = new EventEmitter<String>();

  
  
}
