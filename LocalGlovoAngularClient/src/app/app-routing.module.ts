import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageAdministradorComponent } from './ui/homePage/home-page-administrador/home-page-administrador.component';
import { LoginComponent } from './ui/login/login/login.component';

const routes: Routes = [
  { path: 'home', component: HomePageAdministradorComponent },
  { path: 'login', component: LoginComponent },
  { path: '**', redirectTo: '/login', pathMatch: 'full' } 
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
