import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.scss'],
})
export class ChildComponent implements OnInit {
  // Input defaults to 0 if not provided.
  @Input() inValue = 0;

  // Output is based on Subject from rxjs.
  @Output() outValue = new EventEmitter<number>();

  constructor() {
    // The binding should not be expected to have
    // been done here.
    console.log('CONSTRUCTOR');
    console.log(this.inValue); // Output: 0
  }

  ngOnInit() {
    // If you didn't want to give a default value,
    // you could mark inValue as optional and
    // throw an error here if undefined.
    console.log('NGONINIT');
    console.log(this.inValue); // Output: 42
  }

  // Helper method for the template to call.
  sendValue(value: number) {
    // Emit is like next() on rxjs subject.
    this.outValue.emit(value);
  }
}
