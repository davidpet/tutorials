import { Component } from '@angular/core';

@Component({
  selector: 'app-parent',
  templateUrl: './parent.component.html',
  styleUrls: ['./parent.component.scss'],
})
export class ParentComponent {
  value = 0;

  captureValue(value: number) {
    // This could have been done inline but
    // I wanted to show the type.
    this.value = value;
  }
}
