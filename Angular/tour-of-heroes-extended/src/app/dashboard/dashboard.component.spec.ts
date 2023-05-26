import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashboardComponent } from './dashboard.component';
import { HeroService } from '../hero.service';
import { Hero } from '../hero';
import { Observable, of } from 'rxjs';
import { Router } from '@angular/router';
import { AppRoutingModule } from '../app-routing.module';
import { HttpClientModule } from '@angular/common/http';
import { HeroSearchComponent } from '../hero-search/hero-search.component';

describe('DashboardComponent', () => {
  let component: DashboardComponent;
  let fixture: ComponentFixture<DashboardComponent>;

  let router: Router;

  const HEROES = [
    { name: 'Hero 1', id: 100 }, // chopped off
    { name: 'Hero 2', id: 200 },
    { name: 'Hero 3', id: 300 }, // to click
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
      declarations: [DashboardComponent, HeroSearchComponent],
      imports: [AppRoutingModule, HttpClientModule],
      providers: [{ provide: HeroService, useClass: FakeHeroService }],
    });
    fixture = TestBed.createComponent(DashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();

    router = TestBed.inject(Router);
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

  it('should reroute on hero button click', () => {
    const heroButtons: HTMLElement[] = Array.from(
      fixture.nativeElement.querySelectorAll('.hero-button')
    );
    const heroButton = heroButtons[1];
    spyOn(router, 'navigateByUrl'); // Spy on the router's navigateByUrl method

    heroButton.click();
    fixture.detectChanges();

    expect(router.navigateByUrl).toHaveBeenCalledWith(
      jasmine.stringMatching('/detail/300'),
      jasmine.any(Object)
    );
  });

  it('should show search bar', () => {
    // TODO: Use page objects instead of reaching in like this.
    expect(fixture.nativeElement.querySelector('.search-bar')).toBeTruthy();
  });
});
