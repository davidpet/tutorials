import { Component } from '@angular/core';
import { ChildrenOutletContexts, Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'routing-tutorial';

  constructor(
    private router: Router,
    private contexts: ChildrenOutletContexts
  ) {}

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

  getAnimationData(): string {
    // This is how you can reach into an outlet to get data passed via routing.
    // In this case, it simulates configuring animation names at the module
    // level and then applying the animations in the root component.
    const data = this.contexts.getContext('primary')?.route?.snapshot?.data as {
      animationName: string;
    };

    return data.animationName || '';
  }
}
