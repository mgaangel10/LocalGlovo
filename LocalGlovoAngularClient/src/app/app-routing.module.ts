import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageAdministradorComponent } from './ui/homePage/home-page-administrador/home-page-administrador.component';
import { LoginComponent } from './ui/login/login/login.component';
import { ComercioListComponent } from './ui/comercios/comercio-list/comercio-list.component';
import { PageComercioDetailsComponent } from './ui/comercios/page-comercio-details/page-comercio-details.component';
import { PageIngredientesDetailsComponent } from './ui/comercios/page-ingredientes-details/page-ingredientes-details.component';
import { PageCrearProductosComponent } from './ui/productos/page-crear-productos/page-crear-productos.component';

const routes: Routes = [
  { path: 'home', component: HomePageAdministradorComponent },
  { path: 'login', component: LoginComponent },
  { path: 'comercio-details/:comercioId', component: PageComercioDetailsComponent },
  { path: 'ingredientes-details/:id', component: PageIngredientesDetailsComponent },
  { path: 'crear-productos/:id', component: PageCrearProductosComponent},
  { path: 'listado-comercios', component: ComercioListComponent },
  { path: '**', redirectTo: '/login', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
