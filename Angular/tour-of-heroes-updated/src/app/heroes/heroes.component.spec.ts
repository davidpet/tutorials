import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';

import { FormsModule } from '@angular/forms';
import { HeroDetailComponent } from '../hero-detail/hero-detail.component';
import { HeroService } from '../hero.service';
import { Hero } from '../hero';
import { Observable, of } from 'rxjs';
import { Router } from '@angular/router';
import { AppRoutingModule } from '../app-routing.module';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  let router: Router;

  const HEROES = [
    { name: 'Hero 1', id: 100 },
    { name: 'Hero 2', id: 200 },
    { name: 'Hero 3', id: 300 },
  ];

  class FakeHeroService extends HeroService {
    override getHeroes(): Observable<Hero[]> {
      return of(HEROES);
    }
  }

  beforeEach(async () => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent, HeroDetailComponent],
      imports: [AppRoutingModule, FormsModule],
      providers: [{ provide: HeroService, useClass: FakeHeroService }],
    });

    fixture = TestBed.createComponent(HeroesComponent);
    component = fixture.componentInstance;
    router = TestBed.inject(Router);

    fixture.detectChanges();
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show title', async () => {
    expect(
      fixture.debugElement.nativeElement.querySelector('h2').textContent
    ).toBe('My Heroes');
  });

  it('should show hero list', async () => {
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

  describe('on hero click', async () => {
    it('should reroute on hero button click', async () => {
      const heroButtons: HTMLElement[] = Array.from(
        fixture.nativeElement.querySelectorAll('.hero-button')
      );
      const heroButton = heroButtons[1];
      spyOn(router, 'navigateByUrl');

      heroButton.click();
      fixture.detectChanges();
      await fixture.whenStable();

      expect(router.navigateByUrl).toHaveBeenCalledWith(
        jasmine.stringMatching('/detail/200'),
        jasmine.any(Object)
      );
    });
  });
});
