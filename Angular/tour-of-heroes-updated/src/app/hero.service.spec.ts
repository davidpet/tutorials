import { TestBed } from '@angular/core/testing';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';
import { Hero } from './hero';
import { MessageService } from './message.service';

describe('HeroService', () => {
  let service: HeroService;

  let messageServiceSpy: jasmine.SpyObj<MessageService>;

  beforeEach(() => {
    messageServiceSpy = jasmine.createSpyObj(MessageService.name, [
      'add',
      'clear',
      'messages',
    ]);
    messageServiceSpy.messages = [];

    TestBed.configureTestingModule({
      providers: [{ provide: MessageService, useValue: messageServiceSpy }],
    });
    service = TestBed.inject(HeroService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get the heroes', () => {
    let emitted: Hero[] = [];
    let emitCount = 0;

    service.getHeroes().subscribe((heroes) => {
      emitted = heroes;
      emitCount++;
    });

    expect(emitted).toEqual(HEROES);
    expect(emitCount).toBe(1);
  });

  it('should send a message when it gets the heroes', () => {
    messageServiceSpy.add.calls.reset();

    service.getHeroes();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  });

  it('should get single hero', () => {
    let emitted: Hero | undefined = undefined;
    let emitCount = 0;

    service.getHero(15).subscribe((hero) => {
      emitted = hero;
      emitCount++;
    });

    expect(emitted!).toEqual({ id: 15, name: 'Magneta' });
    expect(emitCount).toBe(1);
  });

  it('should send a message when it gets a hero', () => {
    messageServiceSpy.add.calls.reset();

    service.getHero(15);

    expect(messageServiceSpy.add).toHaveBeenCalled();
  });
});
