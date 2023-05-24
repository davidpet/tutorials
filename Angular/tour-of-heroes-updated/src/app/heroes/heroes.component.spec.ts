import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';
import { FormsModule } from '@angular/forms';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent],
      imports: [FormsModule],
    });
    fixture = TestBed.createComponent(HeroesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show title', async () => {
    await fixture.whenStable();

    expect(
      fixture.debugElement.nativeElement.querySelector('h2').textContent
    ).toBe('My Heroes');
  });

  it('should show hero details', async () => {
    await fixture.whenStable();

    const nameElements: HTMLElement[] = Array.from(
      fixture.debugElement.nativeElement.querySelectorAll('.name')
    );
    expect(nameElements.map((e) => e.textContent)).toEqual(
      component.heroes.map((e) => e.name)
    );

    const badgeElements: HTMLElement[] = Array.from(
      fixture.debugElement.nativeElement.querySelectorAll('.badge')
    );
    expect(badgeElements.map((e) => e.textContent)).toEqual(
      component.heroes.map((e) => e.id.toString())
    );
  });
});
