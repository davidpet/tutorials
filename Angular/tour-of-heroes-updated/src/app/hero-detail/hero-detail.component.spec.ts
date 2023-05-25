import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroDetailComponent } from './hero-detail.component';
import { HeroesComponent } from '../heroes/heroes.component';
import { FormsModule } from '@angular/forms';
import { Location } from '@angular/common';
import { RouterTestingModule } from '@angular/router/testing';
import { ActivatedRoute, convertToParamMap } from '@angular/router';
import { HeroService } from '../hero.service';
import { Observable, of } from 'rxjs';
import { Hero } from '../hero';
import { HttpClientModule } from '@angular/common/http';

describe('HeroDetailComponent', () => {
  const ID = '200';

  let component: HeroDetailComponent;
  let fixture: ComponentFixture<HeroDetailComponent>;

  let heroes: Hero[] = [];

  class FakeHeroService extends HeroService {
    override getHeroes(): Observable<Hero[]> {
      return of(heroes);
    }

    override getHero(id: number): Observable<Hero> {
      return of(heroes.find((h) => h.id === id)!);
    }
  }

  beforeEach(async () => {
    heroes = [
      { name: 'Hero 1', id: 100 },
      { name: 'Hero 2', id: 200 }, // returned
      { name: 'Hero 3', id: 300 },
    ];

    TestBed.configureTestingModule({
      declarations: [HeroDetailComponent, HeroesComponent],
      imports: [FormsModule, HttpClientModule, RouterTestingModule],
      providers: [
        {
          provide: ActivatedRoute,
          useValue: {
            snapshot: { paramMap: convertToParamMap({ id: ID }) },
          },
        },
        { provide: HeroService, useClass: FakeHeroService },
      ],
    });
    fixture = TestBed.createComponent(HeroDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show correct hero details based on url param', async () => {
    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');
    expect(heroElement.querySelector('h2').textContent).toContain('HERO 2');

    expect(heroElement.querySelector('.id').textContent).toContain(200);
    expect(heroElement.querySelector('input').value).toBe('Hero 2');
  });

  it('should update hero name on user edit', async () => {
    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');

    heroElement.querySelector('input').value = 'Dr. React';
    heroElement.querySelector('input').dispatchEvent(new Event('input'));
    fixture.detectChanges();
    await fixture.whenStable();

    expect(heroes[1]).toEqual({ name: 'Dr. React', id: 200 });
    expect(heroElement.querySelector('h2').textContent).toContain('DR. REACT');
    expect(heroElement.querySelector('.id').textContent).toContain(200);
    expect(heroElement.querySelector('input').value).toBe('Dr. React');
  });

  it('should navigate back on back button click', async () => {
    const location = TestBed.inject(Location);
    const backSpy = spyOn(location, 'back');

    fixture.debugElement.nativeElement.querySelector('.back-button').click();
    fixture.detectChanges();
    await fixture.whenStable();

    expect(backSpy).toHaveBeenCalled();
  });
});
