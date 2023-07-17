import { Component } from '@angular/core';

@Component({
  selector: 'lib-my-lib',
  template: `
    <p>
      my-lib works!!!
    </p>
    <lib-common-lib></lib-common-lib>
  `,
  styles: [
  ]
})
export class MyLibComponent {

}
