import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DefaultChangeDetectionComponent } from './default-change-detection.component';

describe('DefaultChangeDetectionComponent', () => {
  let component: DefaultChangeDetectionComponent;
  let fixture: ComponentFixture<DefaultChangeDetectionComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DefaultChangeDetectionComponent]
    });
    fixture = TestBed.createComponent(DefaultChangeDetectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
