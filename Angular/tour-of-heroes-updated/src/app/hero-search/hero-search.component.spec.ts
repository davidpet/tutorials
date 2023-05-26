import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';

import { HeroSearchComponent } from './hero-search.component';
import { HeroService } from '../hero.service';
import { of } from 'rxjs';

import { HEROES } from '../mock-heroes';
import { Router } from '@angular/router';

describe('HeroSearchComponent', () => {
  let component: HeroSearchComponent;
  let fixture: ComponentFixture<HeroSearchComponent>;

  let heroServiceSpy: jasmine.SpyObj<HeroService>;

  async function enterInputValue(value: string) {
    const inputElement = fixture.nativeElement.querySelector('input');
    inputElement.value = value;
    inputElement.dispatchEvent(new Event('input'));

    fixture.detectChanges();
    await fixture.whenStable();
    // We have to do this twice to get the async pipe to pick it up.
    fixture.detectChanges();
    await fixture.whenStable();
  }

  function getHeroButtons(): HTMLElement[] {
    return Array.from(fixture.nativeElement.querySelectorAll('.hero-link'));
  }

  function getHeroButtonNames(): string[] {
    const heroButtons = getHeroButtons();
    return heroButtons.map((b) => (b.textContent ?? '').trim());
  }

  beforeEach(async () => {
    heroServiceSpy = jasmine.createSpyObj(HeroService.name, ['searchHeroes']);

    TestBed.configureTestingModule({
      declarations: [HeroSearchComponent],
      imports: [RouterTestingModule],
      providers: [{ provide: HeroService, useValue: heroServiceSpy }],
    });
    fixture = TestBed.createComponent(HeroSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should initially have no results', () => {
    expect(fixture.nativeElement.querySelector('.hero-result')).toBeFalsy();

    expect(heroServiceSpy.searchHeroes).not.toHaveBeenCalled();
  });

  it('should get results after typing', async () => {
    heroServiceSpy.searchHeroes.and.returnValue(of(HEROES));

    await enterInputValue('somehero');

    expect(heroServiceSpy.searchHeroes).toHaveBeenCalledWith('somehero');
    expect(getHeroButtonNames()).toEqual(HEROES.map((h) => h.name));
  });

  it('should change results after typing again', async () => {
    const firstHeroes = [
      { name: 'Hero 1', id: 100 },
      { name: 'Hero 2', id: 200 },
    ];
    const secondHeroes = [
      { name: 'Villain 1', id: 300 },
      { name: 'Villain 2', id: 400 },
    ];
    let nextHeroes = firstHeroes;
    heroServiceSpy.searchHeroes.and.callFake((_) => {
      return of(nextHeroes);
    });
    await enterInputValue('Hero');
    heroServiceSpy.searchHeroes.calls.reset();

    nextHeroes = secondHeroes;
    await enterInputValue('Villain');

    expect(heroServiceSpy.searchHeroes).toHaveBeenCalledWith('Villain');
    expect(getHeroButtonNames()).toEqual(secondHeroes.map((h) => h.name));
  });

  it('should route correctly on hero button click', async () => {
    heroServiceSpy.searchHeroes.and.returnValue(of(HEROES));
    await enterInputValue('somehero');
    const router = TestBed.inject(Router);
    spyOn(router, 'navigateByUrl');

    const heroButton = getHeroButtons()[1]; // Bombasto, #13
    heroButton.click();
    fixture.detectChanges();
    await fixture.whenStable();

    expect(router.navigateByUrl).toHaveBeenCalledWith(
      jasmine.stringMatching('/detail/13'),
      jasmine.any(Object)
    );
  });
});
