import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';

import { FormsModule } from '@angular/forms';
import { HeroDetailComponent } from '../hero-detail/hero-detail.component';
import { HeroService } from '../hero.service';
import { Hero } from '../hero';
import { Observable, of } from 'rxjs';
import { Router } from '@angular/router';
import { AppRoutingModule } from '../app-routing.module';
import { HttpClientModule } from '@angular/common/http';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  let router: Router;

  const HEROES = [
    { name: 'Hero 1', id: 100 },
    { name: 'Hero 2', id: 200 },
    { name: 'Hero 3', id: 300 },
  ];

  const ADDED_ID = 142;

  // Just tracks and returns - doesn't modify the internal heroes list.
  class FakeHeroService extends HeroService {
    addedHero?: Hero;
    deletedHero?: Hero;

    override getHeroes(): Observable<Hero[]> {
      return of([...HEROES]);
    }

    override addHero(hero: Hero): Observable<Hero> {
      this.addedHero = hero;
      this.addedHero.id = 142;

      return of(hero);
    }

    override deleteHero(id: number): Observable<Hero> {
      this.deletedHero = HEROES.find((h) => h.id === id);

      return of(this.deletedHero!);
    }
  }

  beforeEach(async () => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent, HeroDetailComponent],
      imports: [AppRoutingModule, FormsModule, HttpClientModule],
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

  describe('on clicking delete', () => {
    beforeEach(async () => {
      const deleteButtons: HTMLElement[] = Array.from(
        fixture.nativeElement.querySelectorAll('.delete')
      );
      const deleteButton = deleteButtons[1];

      deleteButton.click();
      fixture.detectChanges();
      await fixture.whenStable();
    });

    it('calls hero service to delete hero', () => {
      const fakeHeroService = TestBed.inject(HeroService) as FakeHeroService;
      expect(fakeHeroService.deletedHero).toEqual(HEROES[1]);
    });

    it('removes hero from own list', () => {
      expect(component.heroes).toEqual([HEROES[0], HEROES[2]]);

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

  describe('on hero click', async () => {
    it('should reroute', async () => {
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

    describe('on save click', () => {
      describe('with valid hero', () => {
        const newName = '   Captain Angular ';
        const trimmedNewName = newName.trim();
        const expectedNewHeroes = [
          ...HEROES,
          { name: trimmedNewName, id: ADDED_ID },
        ];

        let fakeHeroService: FakeHeroService | undefined;

        beforeEach(async () => {
          fakeHeroService = TestBed.inject(HeroService) as FakeHeroService;

          const nameInput = fixture.nativeElement.querySelector('#new-hero');
          const buttonInput =
            fixture.nativeElement.querySelector('.add-button');

          nameInput.value = newName;
          nameInput.dispatchEvent(new Event('input'));
          buttonInput.click();
          fixture.detectChanges();
          await fixture.whenStable();
        });

        it('should "put" to server and update local list', async () => {
          expect(fakeHeroService!.addedHero).toEqual({
            name: trimmedNewName,
            id: ADDED_ID,
          });

          const nameElements: HTMLElement[] = Array.from(
            fixture.debugElement.nativeElement.querySelectorAll('.name')
          );
          expect(nameElements.map((e) => e.textContent)).toEqual(
            expectedNewHeroes.map((e) => e.name)
          );

          const badgeElements: HTMLElement[] = Array.from(
            fixture.debugElement.nativeElement.querySelectorAll('.badge')
          );
          expect(badgeElements.map((e) => e.textContent)).toEqual(
            expectedNewHeroes.map((e) => e.id.toString())
          );
        });
      });

      describe('with empty name', () => {
        const emptyName = '    ';

        let fakeHeroService: FakeHeroService | undefined;

        beforeEach(async () => {
          fakeHeroService = TestBed.inject(HeroService) as FakeHeroService;

          const nameInput = fixture.nativeElement.querySelector('#new-hero');
          const buttonInput =
            fixture.nativeElement.querySelector('.add-button');

          nameInput.value = emptyName;
          nameInput.dispatchEvent(new Event('input'));
          buttonInput.click();
          fixture.detectChanges();
          await fixture.whenStable();
        });

        it('should do nothing if empty name', async () => {
          expect(fakeHeroService!.addedHero).toBeUndefined();

          const nameElements: HTMLElement[] = Array.from(
            fixture.debugElement.nativeElement.querySelectorAll('.name')
          );
          expect(nameElements.map((e) => e.textContent)).toEqual(
            HEROES.map((e) => e.name)
          );

          const badgeElements: HTMLElement[] = Array.from(
            fixture.debugElement.nativeElement.querySelectorAll('.badge')
          );
          expect(badgeElements.map((e) => e.textContent)).toEqual(
            HEROES.map((e) => e.id.toString())
          );
        });
      });
    });
  });
});
