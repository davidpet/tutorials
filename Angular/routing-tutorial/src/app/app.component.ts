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
      animationName?: string;
    };

    return data?.animationName || '';
  }

  navigateToSecondary() {
    // Route secondary outlet only, leaving the primary one alone.
    // inner [] is url components
    // outer {} presumably lets you route multiple outlets together
    // I have no idea what the outer [] implies in this context as
    // it is usually the url components.  I couldn't find much info.
    this.router.navigate([{ outlets: { bobTheOutlet: ['secondary'] } }]);
  }

  // For isActive, you need to put () around and give the outlet name
  // like this.
  secondaryIsActive(): boolean {
    // replacing the routerLinkActive attribute
    return this.router.isActive('(bobTheOutlet:secondary)', false);
  }

  secondaryIsCurrent(): string {
    // replacing the aria attribute
    return this.router.isActive('(bobTheOutlet:secondary)', false)
      ? 'page'
      : '';
  }
}
