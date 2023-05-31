import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from './auth.service';
import { map } from 'rxjs';

// WARNING: if you try to activate from the same route (already on FirstComponent),
// these won't even run because the router knows you're already there.
export const authGuard: CanActivateFn = (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  if (authService.authorized) {
    // Routing goes through transparently.
    return true;
  }

  // Returning false would just ignore routing
  // without falling through to the next one or
  // anything.

  //return false;

  // Redirect to another page
  return router.parseUrl('/second-component');
};

export const authGuardAsync: CanActivateFn = (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  // You can return a sync value, an observable, a promise,
  // or a url tree.
  // The choice is transparent to the router config and
  // gives you the flexibility to do sync or async authorization.
  return authService
    .fetch()
    .pipe(map((b) => b || router.parseUrl('/second-component')));
};
