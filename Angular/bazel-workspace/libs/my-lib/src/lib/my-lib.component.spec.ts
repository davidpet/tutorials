import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MyLibComponent } from './my-lib.component';
import { CommonLibModule } from 'common-lib';

describe('MyLibComponent', () => {
  let component: MyLibComponent;
  let fixture: ComponentFixture<MyLibComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MyLibComponent],
      imports: [CommonLibModule]
    });
    fixture = TestBed.createComponent(MyLibComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
