import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';
import { HEROES } from '../mock-heroes';

import { FormsModule } from '@angular/forms';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  beforeEach(async () => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent],
      imports: [FormsModule],
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

    it('should show correct hero details', async () => {
      const heroElement =
        fixture.debugElement.nativeElement.querySelector('.hero');
      expect(heroElement.querySelector('h2').textContent).toContain(
        HEROES[1].name.toUpperCase()
      );

      expect(heroElement.querySelector('.id').textContent).toContain(
        HEROES[1].id
      );
      expect(heroElement.querySelector('input').value).toBe(HEROES[1].name);
    });

    it('should reflect name change everywhere after user edit', async () => {
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
