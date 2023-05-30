import {
  Directive,
  ElementRef,
  EventEmitter,
  HostListener,
  Input,
  Output,
} from '@angular/core';

@Directive({
  selector: '[appAttributeDirective]',
})
export class AttributeDirectiveDirective {
  constructor(private el: ElementRef) {
    el.nativeElement.style.backgroundColor = 'lightblue';
  }

  @HostListener('click') onClick() {
    this.outHandler.emit(this.x++);
  }

  @Input() x = 0;

  @Output() outHandler = new EventEmitter<number>();
}
