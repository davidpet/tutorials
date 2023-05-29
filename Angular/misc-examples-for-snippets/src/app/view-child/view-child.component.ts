import {
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  QueryList,
  ViewChild,
  ViewChildren,
} from '@angular/core';
import { ChildComponentComponent } from './child-component/child-component.component';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-view-child',
  templateUrl: './view-child.component.html',
  styleUrls: ['./view-child.component.scss'],
})
export class ViewChildComponent implements OnInit, AfterViewInit {
  shownX?: number;
  removedFirst = false;

  // Emits every time an element is added or removed.
  childChanges?: Observable<QueryList<ChildComponentComponent>>;

  // Whatever the first instance of the component is after each change
  // detection round.
  @ViewChild(ChildComponentComponent)
  childComponent!: ChildComponentComponent;

  // Native DOM element via template reference variable.
  @ViewChild('mybutton')
  button!: ElementRef;

  // List of the same component, dynamically updated.
  // You can subscribe to see changes.
  @ViewChildren(ChildComponentComponent)
  childComponents!: QueryList<ChildComponentComponent>;

  disable() {
    // This is how to interact with a native element.
    // Because it's inside the ngZone (due to being
    // triggered by our click handler), and because
    // change detection runs after this, it works.
    this.button.nativeElement.disabled = true;
  }

  showX() {
    // You can access properies of the component class itself
    // instead of having to use the DOM.
    this.shownX = this.childComponent.x;
  }

  removeFirst() {
    // Just using this to change which child component is seen
    // by the first @ViewChild.
    this.removedFirst = true;
  }

  ngOnInit() {
    // All undefined.
    console.log(`OnInit childComponent: ${this.childComponent}`);
    console.log(`OnInit button: ${this.button}`);
    console.log(`OnInit childComponents: ${this.childComponents}`);
  }

  ngAfterViewInit() {
    // All populated.
    console.log(`AfterViewInit childComponent: ${this.childComponent}`);
    console.log(`AfterViewInit button: ${this.button}`);
    console.log(`AfterViewInit childComponents: ${this.childComponents}`);

    // We didn't need to store the observable.
    // I just did that to show the type of it.
    this.childChanges = this.childComponents.changes;
    this.childChanges.subscribe((childChanges) => {
      console.log(childChanges);
    });
  }
}
