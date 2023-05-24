import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroDetailComponent } from './hero-detail.component';
import { HeroesComponent } from '../heroes/heroes.component';
import { FormsModule } from '@angular/forms';
import { HEROES } from '../mock-heroes';

describe('HeroDetailComponent', () => {
  let component: HeroDetailComponent;
  let fixture: ComponentFixture<HeroDetailComponent>;

  beforeEach(async () => {
    TestBed.configureTestingModule({
      declarations: [HeroDetailComponent, HeroesComponent],
      imports: [FormsModule],
    });
    fixture = TestBed.createComponent(HeroDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should not show initially', async () => {
    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');
    expect(heroElement).toBeFalsy();
  });

  it('should show correct hero details on hero selection', async () => {
    component.hero = { name: 'Captain Angular', id: 42 };
    fixture.detectChanges();
    await fixture.whenStable();

    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');
    expect(heroElement.querySelector('h2').textContent).toContain(
      'CAPTAIN ANGULAR'
    );

    expect(heroElement.querySelector('.id').textContent).toContain(42);
    expect(heroElement.querySelector('input').value).toBe('Captain Angular');
  });

  it('should update hero name on user edit', async () => {
    const myHero = { name: 'Captain Angular', id: 42 };
    component.hero = myHero;
    fixture.detectChanges();
    await fixture.whenStable();

    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');
    heroElement.querySelector('input').value = 'Dr. React';
    heroElement.querySelector('input').dispatchEvent(new Event('input'));
    fixture.detectChanges();
    await fixture.whenStable();

    expect(myHero).toEqual({ name: 'Dr. React', id: 42 });
  });
});
