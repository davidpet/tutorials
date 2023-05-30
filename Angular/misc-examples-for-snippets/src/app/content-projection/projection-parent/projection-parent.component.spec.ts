import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProjectionParentComponent } from './projection-parent.component';

describe('ProjectionParentComponent', () => {
  let component: ProjectionParentComponent;
  let fixture: ComponentFixture<ProjectionParentComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ProjectionParentComponent]
    });
    fixture = TestBed.createComponent(ProjectionParentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
