import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageAdministradorComponent } from './ui/homePage/home-page-administrador/home-page-administrador.component';
import { LoginComponent } from './ui/login/login/login.component';
import { ComercioListComponent } from './ui/comercios/comercio-list/comercio-list.component';
import { PageComercioDetailsComponent } from './ui/comercios/page-comercio-details/page-comercio-details.component';

const routes: Routes = [
  { path: 'home', component: HomePageAdministradorComponent },
  { path: 'login', component: LoginComponent },
  { path: 'comercio-details/:id', component: PageComercioDetailsComponent },
  { path: 'listado-comercios', component: ComercioListComponent },
  { path: '**', redirectTo: '/login', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
