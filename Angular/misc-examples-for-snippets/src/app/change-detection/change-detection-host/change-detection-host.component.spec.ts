import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChangeDetectionHostComponent } from './change-detection-host.component';

describe('ChangeDetectionHostComponent', () => {
  let component: ChangeDetectionHostComponent;
  let fixture: ComponentFixture<ChangeDetectionHostComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ChangeDetectionHostComponent]
    });
    fixture = TestBed.createComponent(ChangeDetectionHostComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
