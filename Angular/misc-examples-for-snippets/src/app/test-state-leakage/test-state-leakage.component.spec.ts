import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TestStateLeakageComponent } from './test-state-leakage.component';

describe('TestStateLeakageComponent', () => {
  /* Example Output:
  !!!!!!!!!!beforeEach root!!!!!!!!!!!
  [1, 2, 3, 4, 5]
  !!!!!!!!!!!beforeEach deeper!!!!!!!!
  current state: undefined
  new state: 1
  !!!!!!!!!!!!!Test Case 1!!!!!!!!!!!!!
  [1, 2, 3, 4, 5, 7]
  !!!!!!!!!!beforeEach root!!!!!!!!!!!
  [1, 2, 3, 4, 5, 7]
  !!!!!!!!!!!beforeEach deeper!!!!!!!!
  current state: 1,100
  new state: 1
  !!!!!!!!!!!!!Test Case 2!!!!!!!!!!!!!
  [1, 2, 3, 4, 5, 7, 8]
  !!!!!!!!!!beforeEach root!!!!!!!!!!!
  [1, 2, 3, 4, 5, 7, 8]
  !!!!!!!!!!!!!Test Case 0!!!!!!!!!!!!!!
  [1, 2, 3, 4, 5, 7, 8, 6] */

  // This looks innocent enough, but SHARED_DATA accumulates changes
  // from all the tests.
  // As each tests runs, it adds more and more to the array, causing
  // other tests to reflect the changes.
  // The order of tests is not always the same, so even if it passes
  // one time, you will have flakey tests that sometimes fail.
  const SHARED_DATA = [1, 2, 3, 4, 5];

  let component: TestStateLeakageComponent;
  let fixture: ComponentFixture<TestStateLeakageComponent>;

  beforeEach(() => {
    console.log('!!!!!!!!!!beforeEach root!!!!!!!!!!!');
    console.log(SHARED_DATA);
    TestBed.configureTestingModule({
      declarations: [TestStateLeakageComponent],
    });
    fixture = TestBed.createComponent(TestStateLeakageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('Test Case 0', () => {
    console.log('!!!!!!!!!!!!!Test Case 0!!!!!!!!!!!!!!');
    SHARED_DATA.push(6);
    console.log(SHARED_DATA);

    expect(component).toBeTruthy();
  });

  describe('deeper tests', () => {
    // Instead of initializing here, we declare it but leave it undefined.
    let state: number[];

    beforeEach(() => {
      console.log('!!!!!!!!!!!beforeEach deeper!!!!!!!!');
      console.log(`current state: ${state}`); // leaked state may still be here
      // It's ok to assign it here because it runs before every
      // test in this describe block.
      state = [1]; // leaked state is gone (as long as we're sure this runs)
      console.log(`new state: ${state}`);
    });

    afterEach(() => {
      // You could do this to set the variables back to undefined
      // if you feel the need, but usually the above way works
      // pretty well.
    });

    it('Test Case 1', () => {
      console.log('!!!!!!!!!!!!!Test Case 1!!!!!!!!!!!!!');
      SHARED_DATA.push(7);
      state.push(100);
      console.log(SHARED_DATA);

      expect(component).toBeTruthy();
    });

    it('Test Case 2', () => {
      console.log('!!!!!!!!!!!!!Test Case 2!!!!!!!!!!!!!');
      SHARED_DATA.push(8);
      state.push(200);
      console.log(SHARED_DATA);

      expect(component).toBeTruthy();
    });
  });
});
