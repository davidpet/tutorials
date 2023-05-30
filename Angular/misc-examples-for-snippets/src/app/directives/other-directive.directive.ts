import { Directive, ElementRef, HostListener, Input } from '@angular/core';

@Directive({
  selector: '.myDirectiveClass',
})
export class OtherDirectiveDirective {
  @Input() x = 0;

  constructor(private el: ElementRef) {
    this.el.nativeElement.style.backgroundColor = 'red';
  }

  @HostListener('click') onClick() {
    console.log(this.x++);
  }
}
