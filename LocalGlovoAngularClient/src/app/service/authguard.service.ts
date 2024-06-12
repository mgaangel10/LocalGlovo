import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthguardService {

  constructor(private router: Router) {}

  canActivate(): boolean {
    let token = localStorage.getItem('TOKEN');
    
    if (token ) {
      
      return true;
    } else {
      
      this.router.navigate(['/login']);
      return false;
    }
  }
}
