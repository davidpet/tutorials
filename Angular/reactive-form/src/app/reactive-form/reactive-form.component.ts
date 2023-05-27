import { Component } from '@angular/core';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-reactive-form',
  templateUrl: './reactive-form.component.html',
  styleUrls: ['./reactive-form.component.scss'],
})
export class ReactiveFormComponent {
  // Form is driven from here instead of the template.
  readonly textControl = new FormControl('');

  setValue() {
    // Reflected in text box right away because change detection will run
    // after the click handler returns.
    // In a template-driven form, you would just set the two-way bound
    // value here.
    this.textControl.setValue('42');
  }
}
