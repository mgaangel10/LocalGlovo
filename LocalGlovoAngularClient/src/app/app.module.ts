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


@NgModule({
    declarations: [
        AppComponent,
        LoginComponent,
        HomePageAdministradorComponent,
        ComercioListComponent,
        ComercioItemComponent,
        PageComercioDetailsComponent,
        ComercioDetailsComponent
    ],
    providers: [],
    bootstrap: [AppComponent],
    imports: [
        ReactiveFormsModule,
        BrowserModule,
        AppRoutingModule,
        AdministradorComponent,
        HttpClientModule,
        NgbModule
    ]
})
export class AppModule { }
