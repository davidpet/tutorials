import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent],
    });
    fixture = TestBed.createComponent(HeroesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show hero details', () => {
    expect(
      fixture.debugElement.nativeElement.querySelector('h2').textContent
    ).toBe(`${component.hero.name.toUpperCase()} Details`);
    expect(
      fixture.debugElement.nativeElement.querySelector('.name').textContent
    ).toBe(`name: ${component.hero.name}`);
    expect(
      fixture.debugElement.nativeElement.querySelector('.id').textContent
    ).toBe(`id: ${component.hero.id}`);
  });
});
