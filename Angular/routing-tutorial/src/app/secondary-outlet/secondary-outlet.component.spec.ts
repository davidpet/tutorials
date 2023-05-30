import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SecondaryOutletComponent } from './secondary-outlet.component';

describe('SecondaryOutletComponent', () => {
  let component: SecondaryOutletComponent;
  let fixture: ComponentFixture<SecondaryOutletComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [SecondaryOutletComponent]
    });
    fixture = TestBed.createComponent(SecondaryOutletComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
