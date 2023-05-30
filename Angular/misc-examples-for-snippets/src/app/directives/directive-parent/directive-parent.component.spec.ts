import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DirectiveParentComponent } from './directive-parent.component';

describe('DirectiveParentComponent', () => {
  let component: DirectiveParentComponent;
  let fixture: ComponentFixture<DirectiveParentComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DirectiveParentComponent]
    });
    fixture = TestBed.createComponent(DirectiveParentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
