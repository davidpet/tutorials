import { TestBed, fakeAsync, flush } from '@angular/core/testing';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';
import { Hero } from './hero';
import { MessageService } from './message.service';
import { HttpClientModule } from '@angular/common/http';
import { HttpClientInMemoryWebApiModule } from 'angular-in-memory-web-api';
import { InMemoryDataService } from './in-memory-data.service';
import { of, throwError } from 'rxjs';

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

  it('should get empty list on http error', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'get');
    spy.and.returnValue(
      throwError(() => new Error('failed because I said so'))
    );
    let emitted: Hero[] = [];
    let emitCount = 0;

    service.getHeroes().subscribe((heroes) => {
      emitted = heroes;
      emitCount++;
    });
    flush();

    expect(emitted).toEqual([]);
    expect(emitCount).toBe(1);
  }));

  it('should send a message when it gets the heroes', fakeAsync(() => {
    messageServiceSpy.add.calls.reset();

    service.getHeroes().subscribe();
    flush();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  }));

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

  it('should get undefined hero on http error', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'get');
    spy.and.returnValue(
      throwError(() => new Error('failed because I said so'))
    );
    let emitted: Hero | undefined = { name: 'initial]', id: 0 };
    let emitCount = 0;

    service.getHero(15).subscribe((hero) => {
      emitted = hero;
      emitCount++;
    });
    flush();

    expect(emitted).toBeUndefined();
    expect(emitCount).toBe(1);
  }));

  it('should send a message when it gets a hero', fakeAsync(() => {
    messageServiceSpy.add.calls.reset();

    service.getHero(15).subscribe();
    flush();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  }));

  it('should update hero', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'put');
    spy.and.returnValue(of([undefined]));
    const newHero = { name: 'Updated Hero', id: 42 };
    let emitCount = 0;

    service.updateHero(newHero).subscribe(() => {
      emitCount++;
    });
    flush();

    expect(spy).toHaveBeenCalledWith(
      'api/heroes',
      newHero,
      jasmine.any(Object)
    );
    expect(emitCount).toBe(1);
  }));

  it('should fail gracefully on update error', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'put');
    spy.and.returnValue(
      throwError(() => new Error('failed because I said so'))
    );
    const newHero = { name: 'Updated Hero', id: 42 };
    let emitCount = 0;

    service.updateHero(newHero).subscribe(() => {
      emitCount++;
    });
    flush();

    expect(spy).toHaveBeenCalledWith(
      'api/heroes',
      newHero,
      jasmine.any(Object)
    );
    expect(emitCount).toBe(1);
  }));

  it('should send a message when it updates a hero', fakeAsync(() => {
    messageServiceSpy.add.calls.reset();

    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'put');
    spy.and.returnValue(of([undefined]));
    const newHero = { name: 'Updated Hero', id: 42 };

    service.updateHero(newHero).subscribe();
    flush();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  }));

  it('should add hero', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'post');
    spy.and.returnValue(of({ name: 'New Hero', id: 121 }));
    const newHero = { name: 'New Hero' };
    let emitCount = 0;
    let emitted: Hero | undefined;

    service.addHero(newHero as Hero).subscribe((hero) => {
      emitCount++;
      emitted = hero;
    });
    flush();

    expect(spy).toHaveBeenCalledWith(
      'api/heroes',
      newHero,
      jasmine.any(Object)
    );
    expect(emitCount).toBe(1);
    expect(emitted).toEqual({ ...newHero, id: 121 });
  }));

  it('should fail gracefully on add error', fakeAsync(() => {
    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'post');
    spy.and.returnValue(
      throwError(() => new Error('failed because I said so'))
    );
    const newHero = { name: 'New Hero' };
    let emitCount = 0;
    let emitted: Hero | undefined;

    service.addHero(newHero as Hero).subscribe((hero) => {
      emitCount++;
      emitted = hero;
    });
    flush();

    expect(spy).toHaveBeenCalledWith(
      'api/heroes',
      newHero,
      jasmine.any(Object)
    );
    expect(emitCount).toBe(1);
    expect(emitted).toBeUndefined();
  }));

  it('should send a message when it adds a hero', fakeAsync(() => {
    messageServiceSpy.add.calls.reset();

    const http = TestBed.inject(HttpClient);
    const spy = spyOn(http, 'post');
    spy.and.returnValue(of({ name: 'bla', id: 'bla' }));
    const newHero = { name: 'Updated Hero' };

    service.addHero(newHero as Hero).subscribe();
    flush();

    expect(messageServiceSpy.add).toHaveBeenCalled();
  }));

  // TODO: I should be checking for message being sent on error as well
  // and possibly checking for console.error and stuff like that.

  // TODO: refactor since there's a lot of repeated code, especially
  // within each CRUD group.
});
