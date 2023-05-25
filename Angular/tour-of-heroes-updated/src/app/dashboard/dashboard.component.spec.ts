import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashboardComponent } from './dashboard.component';
import { HeroService } from '../hero.service';
import { Hero } from '../hero';
import { Observable, of } from 'rxjs';

describe('DashboardComponent', () => {
  let component: DashboardComponent;
  let fixture: ComponentFixture<DashboardComponent>;

  const HEROES = [
    { name: 'Hero 1', id: 100 }, // chopped off
    { name: 'Hero 2', id: 200 },
    { name: 'Hero 3', id: 300 },
    { name: 'Hero 4', id: 400 },
    { name: 'Hero 5', id: 500 },
    { name: 'Hero 6', id: 600 }, // chopped off
  ];

  class FakeHeroService extends HeroService {
    override getHeroes(): Observable<Hero[]> {
      return of(HEROES);
    }
  }

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DashboardComponent],
      providers: [{ provide: HeroService, useClass: FakeHeroService }],
    });
    fixture = TestBed.createComponent(DashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show the hero buttons', () => {
    const heroButtons: HTMLElement[] = Array.from(
      fixture.nativeElement.querySelectorAll('.hero-button')
    );
    const heroNames = heroButtons.map((e) => e.textContent?.trim());

    expect(heroNames).toEqual(HEROES.map((h) => h.name).slice(1, 5));
  });
});
