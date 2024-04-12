import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageAdministradorComponent } from './ui/homePage/home-page-administrador/home-page-administrador.component';
import { LoginComponent } from './ui/login/login/login.component';
import { ComercioListComponent } from './ui/comercios/comercio-list/comercio-list.component';
import { PageComercioDetailsComponent } from './ui/comercios/page-comercio-details/page-comercio-details.component';
import { PageIngredientesDetailsComponent } from './ui/comercios/page-ingredientes-details/page-ingredientes-details.component';
import { PageCrearProductosComponent } from './ui/productos/page-crear-productos/page-crear-productos.component';
import { PageUsuariosComponent } from './ui/usuarios/page-usuarios/page-usuarios.component';
import { AddComercioPageComponent } from './ui/comercios/add-comercio-page/add-comercio-page.component';
import { AddIngredientesPageComponent } from './ui/add-ingredientes/add-ingredientes-page/add-ingredientes-page.component';
import { PageEditarProductoComponent } from './ui/productos/page-editar-producto/page-editar-producto.component';

const routes: Routes = [
  { path: 'home', component: HomePageAdministradorComponent },
  { path: 'login', component: LoginComponent },
  { path: 'addComercio', component: AddComercioPageComponent },
  { path: 'comercio-details/:comercioId', component: PageComercioDetailsComponent },
  { path: 'usuarioid/:usuarioId', component: PageUsuariosComponent },
  { path: 'usuarios', component: PageUsuariosComponent },
  { path: 'ingredientes-details/:id', component: PageIngredientesDetailsComponent },
  { path: 'editar-producto/:id', component: PageEditarProductoComponent },
  { path: 'crear-ingredientes/:id', component: AddIngredientesPageComponent},
  { path: 'crear-productos/:id', component: PageCrearProductosComponent},
  { path: 'listado-comercios', component: ComercioListComponent },
  { path: '**', redirectTo: '/login', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
