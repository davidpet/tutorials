import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { forbiddenNameValidator } from '../forbidden-name-validator';

// Declare to protect it from name-mangling.
declare interface TextGroup {
  text1: string;
  text2: string;
  subform: {
    text3: string;
  };

  dynamicFields: string[];
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
    this.textGroup = fb.nonNullable.group({
      // The form still emits events and updates template on invalid
      // input, but you can see that the status changes.
      'text1': ['initial', Validators.required],
      'text2': [
        '',
        [
          Validators.required,
          Validators.minLength(3),
          forbiddenNameValidator(/bob/i),
        ],
      ],
      'subform': fb.nonNullable.group({
        'text3': [''],
      }),
      'dynamicFields': fb.nonNullable.array([['']]),
    });
  }

  get aliases(): FormArray {
    return this.textGroup.get('dynamicFields') as FormArray;
  }

  get text2() {
    return this.textGroup.get('text2')!;
  }

  addAlias() {
    this.aliases.push(this.fb.nonNullable.control(''));
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
    this.aliases.push(this.fb.control('', { nonNullable: true }));

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

  resetForm() {
    this.textGroup.reset();
  }
}
