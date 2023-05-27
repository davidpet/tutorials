import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';

// Declare to protect it from name-mangling.
declare interface TextGroup {
  text1?: string | null;
  text2?: string | null;
  subform?: {
    text3?: string | null;
  };

  dynamicFields?: (string | null)[];
}

@Component({
  selector: 'app-reactive-form',
  templateUrl: './reactive-form.component.html',
  styleUrls: ['./reactive-form.component.scss'],
})
export class ReactiveFormComponent implements OnInit {
  textGroupChanges$!: Observable<TextGroup>;
  text1Changes$!: Observable<string | null>;

  readonly textGroup!: FormGroup;

  constructor(private fb: FormBuilder) {
    this.textGroup = fb.group({
      // The form still emits events and updates template on invalid
      // input, but you can see that the status changes.
      'text1': ['', Validators.required],
      'text2': ['', Validators.minLength(3)],
      'subform': fb.group({
        'text3': [''],
      }),
      'dynamicFields': fb.array([fb.control('')]),
    });
  }

  get aliases(): FormArray {
    return this.textGroup.get('dynamicFields') as FormArray;
  }

  addAlias() {
    this.aliases.push(this.fb.control(''));
  }

  ngOnInit() {
    this.textGroupChanges$ = this.textGroup.valueChanges;
    this.text1Changes$ = this.textGroup.get('text1')!.valueChanges;
  }

  setValue() {
    // setValue can't build a new array
    // so we need to make it match the shape we want
    // then we can set the value(s) below
    this.aliases.clear();
    this.aliases.push(this.fb.control(''));

    this.textGroup.setValue({
      'text1': '42',
      'text2': '44', // We'll never physically see this because of below.
      'subform': {
        'text3': '100',
      },
      'dynamicFields': [''],
    });
    this.textGroup.get('text2')?.setValue('46');
  }

  patchValue() {
    // Values you don't specify are left alone.
    this.textGroup.patchValue({
      'text2': '200',
      'subform': { 'text3': '300' },
    });
  }
}
