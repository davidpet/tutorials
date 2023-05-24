import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';

import { FormsModule } from '@angular/forms';
import { HeroDetailComponent } from '../hero-detail/hero-detail.component';
import { HeroService } from '../hero.service';
import { Hero } from '../hero';
import { Observable, of } from 'rxjs';
import { MessageService } from '../message.service';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  let messageServiceSpy: jasmine.SpyObj<MessageService>;

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
    messageServiceSpy = jasmine.createSpyObj(MessageService.name, [
      'add',
      'clear',
      'messages',
    ]);
    messageServiceSpy.messages = [];

    TestBed.configureTestingModule({
      declarations: [HeroesComponent, HeroDetailComponent],
      imports: [FormsModule],
      providers: [
        { provide: HeroService, useClass: FakeHeroService },
        { provide: MessageService, useValue: messageServiceSpy },
      ],
    });

    fixture = TestBed.createComponent(HeroesComponent);
    component = fixture.componentInstance;
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

  it('should not show hero details section initially', async () => {
    const heroElement =
      fixture.debugElement.nativeElement.querySelector('.hero');
    expect(heroElement).toBeFalsy();
  });

  describe('on hero click', async () => {
    beforeEach(async () => {
      fixture.debugElement.nativeElement.querySelectorAll('button')[1].click();
      fixture.detectChanges();
      await fixture.whenStable();
    });

    it('should show hero details section', async () => {
      const heroElement =
        fixture.debugElement.nativeElement.querySelector('.hero');
      expect(heroElement).toBeTruthy();
    });

    it('should change button', async () => {
      const buttonElements: HTMLElement[] = Array.from(
        fixture.debugElement.nativeElement.querySelectorAll('button')
      );
      const buttonClasses = buttonElements.map((e) => Array.from(e.classList));
      const buttonSelections = buttonClasses.map((classes) =>
        classes.includes('selected')
      );

      expect(buttonSelections[1]).toBeTrue();
      const selectedCount = buttonSelections.reduce(
        (count, selected) => count + (selected ? 1 : 0),
        0
      );
      expect(selectedCount).toBe(1);
    });

    it('should send message', async () => {
      expect(messageServiceSpy.add).toHaveBeenCalledWith(
        'HeroesComponent: Selected hero id=200'
      );
    });

    it('should reflect name change everywhere after user edit', async () => {
      // TODO: use a page object or mock the child component
      // so we don't have to reach inside like this.
      const heroElement =
        fixture.debugElement.nativeElement.querySelector('.hero');
      heroElement.querySelector('input').value = 'Captain Angular';
      heroElement.querySelector('input').dispatchEvent(new Event('input'));
      fixture.detectChanges();
      await fixture.whenStable();

      expect(heroElement.querySelector('h2').textContent).toContain(
        'CAPTAIN ANGULAR'
      );
      expect(heroElement.querySelector('.id').textContent).toContain(
        HEROES[1].id
      );
      expect(heroElement.querySelector('input').value).toBe('Captain Angular');
      expect(
        fixture.debugElement.nativeElement.querySelectorAll('button')[1]
          .textContent
      ).toContain('Captain Angular');
    });
  });
});
