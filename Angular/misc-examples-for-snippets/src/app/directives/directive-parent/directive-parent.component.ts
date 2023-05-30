import { Component } from '@angular/core';

@Component({
  selector: 'app-directive-parent',
  templateUrl: './directive-parent.component.html',
  styleUrls: ['./directive-parent.component.scss']
})
export class DirectiveParentComponent {
  handleOut(x: number) {
    console.log(x);
  }
}
