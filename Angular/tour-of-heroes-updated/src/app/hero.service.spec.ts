import { TestBed } from '@angular/core/testing';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';
import { Hero } from './hero';

describe('HeroService', () => {
  let service: HeroService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HeroService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get the heroes', () => {
    let emitted: Hero[] = [];
    let emitCount = 0;

    service.getHeroes().subscribe(heroes => {
      emitted = heroes;
      emitCount++;
    });

    expect(emitted).toEqual(HEROES);
    expect(emitCount).toBe(1);
  });
});
