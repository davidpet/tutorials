import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'routing-tutorial';

  constructor(private router: Router) {}

  navigateToFirst(id: string) {
    // takes an array of URL segments
    this.router.navigate(['/first-component', id]);
  }

  isActive(): boolean {
    // replacing the routerLinkActive attribute
    return this.router.isActive('/first-component', false);
  }

  isCurrent(): string {
    // replacing the aria attribute
    return this.router.isActive('/first-component', false) ? 'page' : '';
  }
}
