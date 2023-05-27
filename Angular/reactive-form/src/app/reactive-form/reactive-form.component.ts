import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-reactive-form',
  templateUrl: './reactive-form.component.html',
  styleUrls: ['./reactive-form.component.scss'],
})
export class ReactiveFormComponent implements OnInit {
  textGroupChanges$!: Observable<{
    text1?: string | null;
    text2?: string | null;
    subform?: {
      text3?: string | null;
    };
  }>;
  text1Changes$!: Observable<string | null>;

  // Form is driven from here instead of the template.
  readonly textControl = new FormControl('');

  readonly textGroup = new FormGroup({
    text1: new FormControl(''),
    text2: new FormControl(''),
    subform: new FormGroup({
      text3: new FormControl(''),
    }),
  });

  ngOnInit() {
    this.textGroupChanges$ = this.textGroup.valueChanges;
    this.text1Changes$ = this.textGroup.get('text1')!.valueChanges;
  }

  setValue() {
    this.textGroup.setValue({
      text1: '42',
      text2: '44', // We'll never physically see this because of below.
      subform: {
        text3: '100',
      },
    });
    this.textGroup.get('text2')?.setValue('46');
  }
}
