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


@NgModule({
    declarations: [
        AppComponent,
        LoginComponent,
        HomePageAdministradorComponent
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