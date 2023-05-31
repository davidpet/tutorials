import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';

// Simulating both async and desync ways to check
// user auth status for demonstrating route guards.
@Injectable({
  providedIn: 'root',
})
export class AuthService {
  authorized = true;

  authorize() {
    this.authorized = true;
  }

  deauthorize() {
    this.authorized = false;
  }

  fetch(): Observable<boolean> {
    return of(this.authorized);
  }
}
