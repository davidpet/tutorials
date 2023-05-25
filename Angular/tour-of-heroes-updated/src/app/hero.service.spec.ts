import { TestBed, fakeAsync, flush } from '@angular/core/testing';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';
import { Hero } from './hero';
import { MessageService } from './message.service';
import { HttpClientModule } from '@angular/common/http';
import { HttpClientInMemoryWebApiModule } from 'angular-in-memory-web-api';
import { InMemoryDataService } from './in-memory-data.service';

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
      imports: [
        HttpClientModule,
        // You're supposed to stop using this in the app when you have a
        // real server, but you could probably keep using it in the tests.
        HttpClientInMemoryWebApiModule.forRoot(InMemoryDataService, {
          dataEncapsulation: false,
        }),
      ],
    });
    service = TestBed.inject(HeroService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get the heroes', fakeAsync(() => {
    let emitted: Hero[] = [];
    let emitCount = 0;

    service.getHeroes().subscribe((heroes) => {
      emitted = heroes;
      emitCount++;
    });
    flush();

    expect(emitted).toEqual(HEROES);
    expect(emitCount).toBe(1);
  }));

  it('should send a message when it gets the heroes', () => {
    messageServiceSpy.add.calls.reset();

    service.getHeroes();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  });

  it('should get single hero', fakeAsync(() => {
    let emitted: Hero | undefined = undefined;
    let emitCount = 0;

    service.getHero(15).subscribe((hero) => {
      emitted = hero;
      emitCount++;
    });
    flush();

    expect(emitted!).toEqual({ id: 15, name: 'Magneta' });
    expect(emitCount).toBe(1);
  }));

  it('should send a message when it gets a hero', () => {
    messageServiceSpy.add.calls.reset();

    service.getHero(15);

    expect(messageServiceSpy.add).toHaveBeenCalled();
  });
});
