import { Component, EventEmitter, OnInit, Output,NgZone,ChangeDetectorRef   } from '@angular/core';
import { Content, ListadoComercioResponse } from '../../../models/listado-comercio-response';
import { ComerciosService } from '../../../service/comercios/comercios.service';
import { ListadoComerciosFiltrados } from '../../../models/listado-filtrado';


@Component({
  selector: 'app-comercio-list',
  templateUrl: './comercio-list.component.html',
  styleUrl: './comercio-list.component.css'
})
export class ComercioListComponent implements OnInit {
  comercioList: Content[] = [];
  results: any[] = [];
  searchTerm: string = '';
  paginaActual: number = 0;
  categorias:string[]=[];
  totalPages: number = 0; 
  
  listadoFiltrado:ListadoComerciosFiltrados[]=[];
  @Output() comercioClick = new EventEmitter<String>();
  constructor(private comercioSer: ComerciosService,private ngZone:NgZone,private cdr:ChangeDetectorRef) { }

 

  comercioClickLista(id: String) {
    this.comercioClick.emit(id);
  }
  ngOnInit(): void {
    this.cargarComercios(this.paginaActual);
    this.listadoCategorias();
    
  }

  cargarComercios(pagina: number) {
    this.comercioSer.ListadoDeComercioResponse(pagina).subscribe((response: ListadoComercioResponse) => {
      this.comercioList = response.content;
      this.results = [...this.comercioList];
      this.totalPages = response.totalPages; 
    });
  }

  
  paginaSiguiente() {
    this.paginaActual++;
    this.cargarComercios(this.paginaActual);
    
  }

  paginaAnterior() {
    if (this.paginaActual > 0) {
      this.paginaActual--;
      this.cargarComercios(this.paginaActual);
    }
  }
  

  buscarComercio(nombre: string) {
    this.comercioSer.getComercioByNombre(nombre).subscribe((response: any) => {
    
      if (Array.isArray(response)) {
        
        this.results = response;
      } else {
       
        this.results = [response];
      }
      this.cdr.detectChanges();
    });
  }
  
  
  
  onKeyUp(event: any) {
    this.searchTerm = event?.target?.value;
    if (this.searchTerm) {
      this.buscarComercio(this.searchTerm);
    } else {
      this.results = [...this.comercioList]; 
    }
  }

  listadoCategorias(){
    this.comercioSer.listadoCategorias().subscribe(c=>{
      this.categorias = c;
      
    })
  }
  cargarTodosLosComercios() {
    this.cargarComercios(this.paginaActual);
  }
  

  filtradoComercio(categoria:string){
    this.comercioSer.filtrarPorCategoria(categoria).subscribe(c=>{
      this.listadoFiltrado = c;
      this.results = this.listadoFiltrado; 
    })
  }
  
  

}
