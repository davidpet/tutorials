import { Component } from '@angular/core';

@Component({
  selector: 'app-projection-parent',
  templateUrl: './projection-parent.component.html',
  styleUrls: ['./projection-parent.component.scss'],
})
export class ProjectionParentComponent {
  clickHandler() {
    console.log('clicked!');
  }
}
