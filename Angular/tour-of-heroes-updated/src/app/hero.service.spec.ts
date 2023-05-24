import { TestBed } from '@angular/core/testing';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';

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
    expect(service.getHeroes()).toEqual(HEROES);
  });
});
