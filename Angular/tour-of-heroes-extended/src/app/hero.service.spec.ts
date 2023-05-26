import { TestBed, fakeAsync, flush } from '@angular/core/testing';
import { HttpClient } from '@angular/common/http';

import { HeroService } from './hero.service';
import { HEROES } from './mock-heroes';
import { Hero } from './hero';
import { MessageService } from './message.service';
import { Observable, of, throwError } from 'rxjs';

describe('HeroService', () => {
  let service: HeroService;

  let messageServiceSpy: jasmine.SpyObj<MessageService>;
  let httpSpy: jasmine.SpyObj<HttpClient>;

  /**
   * Wrap a service call and capture emitted observable values.
   *
   * This should be called in a fakeAsync context.
   */
  function callServiceMethod<T>(
    method: () => Observable<T>,
    defaultEmitted: T | undefined = undefined
  ): [T | undefined, number] {
    let emitted = defaultEmitted;
    let emitCount = 0;

    method().subscribe((ret) => {
      emitCount++;
      emitted = ret;
    });
    flush();

    return [emitted, emitCount];
  }

  beforeEach(() => {
    messageServiceSpy = jasmine.createSpyObj(MessageService.name, [
      'add',
      'clear',
      'messages',
    ]);
    messageServiceSpy.messages = [];

    httpSpy = jasmine.createSpyObj(HttpClient.name, [
      'get',
      'put',
      'post',
      'delete',
    ]);

    TestBed.configureTestingModule({
      providers: [
        { provide: MessageService, useValue: messageServiceSpy },
        { provide: HttpClient, useValue: httpSpy },
      ],
    });
    service = TestBed.inject(HeroService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('get heroes', () => {
    it('should get the heroes', fakeAsync(() => {
      httpSpy.get.and.returnValue(of(HEROES));

      let [emitted, emitCount] = callServiceMethod(() => service.getHeroes());

      expect(httpSpy.get).toHaveBeenCalledWith('api/heroes');
      expect(emitted).toEqual(HEROES);
      expect(emitCount).toBe(1);
    }));

    it('should get empty list on http error', fakeAsync(() => {
      httpSpy.get.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );

      let [emitted, emitCount] = callServiceMethod(() => service.getHeroes());

      expect(emitted).toEqual([]);
      expect(emitCount).toBe(1);
    }));

    it('should send a message when it gets the heroes', fakeAsync(() => {
      httpSpy.get.and.returnValue(of(HEROES));
      messageServiceSpy.add.calls.reset();

      callServiceMethod(() => service.getHeroes());

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  describe('get hero', () => {
    it('should return correct hero', fakeAsync(() => {
      httpSpy.get.and.returnValue(of({ id: 15, name: 'Magneta' }));

      let [emitted, emitCount] = callServiceMethod(() => service.getHero(15));

      expect(httpSpy.get).toHaveBeenCalledWith('api/heroes/15');
      expect(emitted!).toEqual({ id: 15, name: 'Magneta' });
      expect(emitCount).toBe(1);
    }));

    it('should get undefined hero on http error', fakeAsync(() => {
      httpSpy.get.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );

      let [emitted, emitCount] = callServiceMethod(() => service.getHero(15), {
        name: 'initial',
        id: 0,
      });

      expect(emitted).toBeUndefined();
      expect(emitCount).toBe(1);
    }));

    it('should send a message', fakeAsync(() => {
      httpSpy.get.and.returnValue(of({ id: 15, name: 'Magneta' }));
      messageServiceSpy.add.calls.reset();

      callServiceMethod(() => service.getHero(15));

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  describe('update hero', () => {
    it('should put and update', fakeAsync(() => {
      httpSpy.put.and.returnValue(of(undefined));
      const newHero = { name: 'Updated Hero', id: 42 };

      let [emitted, emitCount] = callServiceMethod(() =>
        service.updateHero(newHero)
      );

      expect(httpSpy.put).toHaveBeenCalledWith(
        'api/heroes',
        newHero,
        jasmine.any(Object)
      );
      expect(emitted).toBeUndefined();
      expect(emitCount).toBe(1);
    }));

    it('should fail gracefully on error', fakeAsync(() => {
      httpSpy.put.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );
      const newHero = { name: 'Updated Hero', id: 42 };

      let [emitted, emitCount] = callServiceMethod(() =>
        service.updateHero(newHero)
      );

      expect(emitted).toBeUndefined();
      expect(emitCount).toBe(1);
    }));

    it('should send a message', fakeAsync(() => {
      messageServiceSpy.add.calls.reset();
      httpSpy.put.and.returnValue(of(undefined));
      const newHero = { name: 'Updated Hero', id: 42 };

      callServiceMethod(() => service.updateHero(newHero));

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  describe('add hero', () => {
    it('should post and update', fakeAsync(() => {
      httpSpy.post.and.returnValue(of({ name: 'New Hero', id: 121 }));
      const newHero = { name: 'New Hero' };

      let [emitted, emitCount] = callServiceMethod(() =>
        service.addHero(newHero as Hero)
      );

      expect(httpSpy.post).toHaveBeenCalledWith(
        'api/heroes',
        newHero,
        jasmine.any(Object)
      );
      expect(emitCount).toBe(1);
      expect(emitted).toEqual({ ...newHero, id: 121 });
    }));

    it('should fail gracefully on error', fakeAsync(() => {
      httpSpy.post.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );
      const newHero = { name: 'New Hero' };

      let [emitted, emitCount] = callServiceMethod(() =>
        service.addHero(newHero as Hero)
      );

      expect(httpSpy.post).toHaveBeenCalledWith(
        'api/heroes',
        newHero,
        jasmine.any(Object)
      );
      expect(emitCount).toBe(1);
      expect(emitted).toBeUndefined();
    }));

    it('should send a message', fakeAsync(() => {
      messageServiceSpy.add.calls.reset();
      httpSpy.post.and.returnValue(of({ name: 'bla', id: 'bla' }));
      const newHero = { name: 'Updated Hero' };

      callServiceMethod(() => service.addHero(newHero as Hero));

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  describe('delete hero hero', () => {
    it('should http delete and remove', fakeAsync(() => {
      const deletedHero: Hero = { name: 'New Hero', id: 121 };
      httpSpy.delete.and.returnValue(of(deletedHero));

      let [emitted, emitCount] = callServiceMethod(() =>
        service.deleteHero(deletedHero.id)
      );

      expect(httpSpy.delete).toHaveBeenCalledWith(
        'api/heroes/121',
        jasmine.any(Object)
      );
      expect(emitCount).toBe(1);
      expect(emitted).toEqual(deletedHero);
    }));

    it('should fail gracefully on error', fakeAsync(() => {
      httpSpy.delete.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );

      let [emitted, emitCount] = callServiceMethod(() =>
        service.deleteHero(42)
      );

      expect(httpSpy.delete).toHaveBeenCalledWith(
        'api/heroes/42',
        jasmine.any(Object)
      );
      expect(emitCount).toBe(1);
      expect(emitted).toBeUndefined();
    }));

    it('should send a message', fakeAsync(() => {
      messageServiceSpy.add.calls.reset();
      httpSpy.delete.and.returnValue(of({ name: 'bla', id: 42 }));

      callServiceMethod(() => service.deleteHero(42));

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  describe('search heroes', () => {
    it('should return correct hero', fakeAsync(() => {
      httpSpy.get.and.returnValue(of(HEROES));

      let [emitted, emitCount] = callServiceMethod(() =>
        service.searchHeroes(' searchHero   ')
      );

      expect(httpSpy.get).toHaveBeenCalledWith('api/heroes?name=searchHero');
      expect(emitted!).toEqual(HEROES);
      expect(emitCount).toBe(1);
    }));

    it('should get empty list on http error', fakeAsync(() => {
      httpSpy.get.and.returnValue(
        throwError(() => new Error('failed because I said so'))
      );

      let [emitted, emitCount] = callServiceMethod(() =>
        service.searchHeroes('doesn"t matter')
      );

      expect(emitted).toEqual([]);
      expect(emitCount).toBe(1);
    }));

    it('should get empty list on blank search term', fakeAsync(() => {
      httpSpy.get.and.returnValue(of(HEROES));

      let [emitted, emitCount] = callServiceMethod(() =>
        service.searchHeroes('    ')
      );

      expect(emitted).toEqual([]);
      expect(emitCount).toBe(1);
    }));

    it('should send a message', fakeAsync(() => {
      httpSpy.get.and.returnValue(of(HEROES));
      messageServiceSpy.add.calls.reset();

      callServiceMethod(() => service.searchHeroes('  searchedHero   '));

      expect(messageServiceSpy.add).toHaveBeenCalled();
    }));
  });

  // TODO: I should be checking for message being sent on error as well
  // and possibly checking for console.error and stuff like that.
});
