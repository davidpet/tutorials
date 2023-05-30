import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProjectionMultiComponent } from './projection-multi.component';

describe('ProjectionMultiComponent', () => {
  let component: ProjectionMultiComponent;
  let fixture: ComponentFixture<ProjectionMultiComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ProjectionMultiComponent]
    });
    fixture = TestBed.createComponent(ProjectionMultiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
