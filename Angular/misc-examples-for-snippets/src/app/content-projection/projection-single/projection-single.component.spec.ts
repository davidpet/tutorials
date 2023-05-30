import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProjectionSingleComponent } from './projection-single.component';

describe('ProjectionSingleComponent', () => {
  let component: ProjectionSingleComponent;
  let fixture: ComponentFixture<ProjectionSingleComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ProjectionSingleComponent]
    });
    fixture = TestBed.createComponent(ProjectionSingleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
