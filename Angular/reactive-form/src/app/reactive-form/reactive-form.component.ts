import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-reactive-form',
  templateUrl: './reactive-form.component.html',
  styleUrls: ['./reactive-form.component.scss'],
})
export class ReactiveFormComponent implements OnInit {
  textChanges$!: Observable<string | null>;

  // Form is driven from here instead of the template.
  readonly textControl = new FormControl('');

  ngOnInit() {
    this.textChanges$ = this.textControl.valueChanges;
  }

  setValue() {
    // Reflected in text box right away because change detection will run
    // after the click handler returns.
    // In a template-driven form, you would just set the two-way bound
    // value here.
    // It also emits to the observable.
    // NOTE: setValue() is called both by this code and by the directive
    // when the user changes the input text manually, triggering
    // the observable to emit.
    this.textControl.setValue('42');
  }
}
