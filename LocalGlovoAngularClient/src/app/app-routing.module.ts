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
import { PageVentasComponent } from './ui/ventas/page-ventas/page-ventas.component';
import { EditarComercioComponent } from './ui/comercios/editar-comercio/editar-comercio.component';
import { AddAdministradorComponent } from './ui/usuarios/add-administrador/add-administrador.component';
import { AuthguardService } from './service/authguard.service';

const routes: Routes = [
  { path: 'home', component: HomePageAdministradorComponent,canActivate: [AuthguardService] },
  { path: 'ver-ventas', component: PageVentasComponent,canActivate: [AuthguardService] },
  { path: 'login', component: LoginComponent },
  { path: 'addComercio', component: AddComercioPageComponent,canActivate: [AuthguardService] },
  { path: 'comercio-details/:comercioId', component: PageComercioDetailsComponent,canActivate: [AuthguardService] },
  { path: 'editar-comercio/:comercioIdEditar', component: EditarComercioComponent,canActivate: [AuthguardService] },
  { path: 'usuarioid/:usuarioId', component: PageUsuariosComponent,canActivate: [AuthguardService] },
  { path: 'usuarios', component: PageUsuariosComponent,canActivate: [AuthguardService] },
  { path: 'add-admin', component: AddAdministradorComponent,canActivate: [AuthguardService] },
  { path: 'ingredientes-details/:id', component: PageIngredientesDetailsComponent,canActivate: [AuthguardService] },
  { path: 'editar-producto/:id', component: PageEditarProductoComponent,canActivate: [AuthguardService] },
  { path: 'crear-ingredientes/:id', component: AddIngredientesPageComponent,canActivate: [AuthguardService] },
  { path: 'crear-productos/:id', component: PageCrearProductosComponent,canActivate: [AuthguardService] },
  { path: 'listado-comercios', component: ComercioListComponent,canActivate: [AuthguardService] },
  { path: '**', redirectTo: '/login', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
