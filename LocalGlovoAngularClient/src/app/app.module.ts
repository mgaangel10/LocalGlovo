import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AdministradorComponent } from "./components/administrador/administrador/administrador.component";
import { HttpClientModule } from '@angular/common/http';
import { LoginComponent } from './ui/login/login/login.component';
import { HomePageAdministradorComponent } from './ui/homePage/home-page-administrador/home-page-administrador.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ComercioListComponent } from './ui/comercios/comercio-list/comercio-list.component';
import { ComercioItemComponent } from './components/comercio-item/comercio-item/comercio-item.component';
import { PageComercioDetailsComponent } from './ui/comercios/page-comercio-details/page-comercio-details.component';
import { ComercioDetailsComponent } from './components/comercio-details/comercio-details/comercio-details.component';
import { PageIngredientesDetailsComponent } from './ui/comercios/page-ingredientes-details/page-ingredientes-details.component';
import { IngredienteItemComponent } from './components/ingrediente-item/ingrediente-item/ingrediente-item.component';
import { PageCrearProductosComponent } from './ui/productos/page-crear-productos/page-crear-productos.component';
import { UsuarioItemComponent } from './components/usuario-item/usuario-item/usuario-item.component';
import { PageUsuariosComponent } from './ui/usuarios/page-usuarios/page-usuarios.component';
import { AddComercioPageComponent } from './ui/comercios/add-comercio-page/add-comercio-page.component';
import { HeaderComponent } from './components/header/header/header.component';
import { AddIngredientesPageComponent } from './ui/add-ingredientes/add-ingredientes-page/add-ingredientes-page.component';
import { PageEditarProductoComponent } from './ui/productos/page-editar-producto/page-editar-producto.component';
import { GoogleMapsModule } from '@angular/google-maps';
import { MapsComponent } from './components/maps/maps.component';
import { PageVentasComponent } from './ui/ventas/page-ventas/page-ventas.component';




@NgModule({
    declarations: [
        AppComponent,
        LoginComponent,
        HomePageAdministradorComponent,
        ComercioListComponent,
        ComercioItemComponent,
        PageComercioDetailsComponent,
        ComercioDetailsComponent,
        PageIngredientesDetailsComponent,
        IngredienteItemComponent,
        PageCrearProductosComponent,
        UsuarioItemComponent,
        PageUsuariosComponent,
        AddComercioPageComponent,
        HeaderComponent,
        AddIngredientesPageComponent,
        PageEditarProductoComponent,
        MapsComponent,
        PageVentasComponent
    ],
    providers: [],
    bootstrap: [AppComponent],
    imports: [
        GoogleMapsModule,
        ReactiveFormsModule,
        BrowserModule,
        AppRoutingModule,
        AdministradorComponent,
        HttpClientModule,
        NgbModule,
        
    ]
})
export class AppModule { }
