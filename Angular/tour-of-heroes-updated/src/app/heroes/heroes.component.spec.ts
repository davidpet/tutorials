import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeroesComponent } from './heroes.component';
import { FormsModule } from '@angular/forms';

describe('HeroesComponent', () => {
  let component: HeroesComponent;
  let fixture: ComponentFixture<HeroesComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [HeroesComponent],
      imports: [FormsModule],
    });
    fixture = TestBed.createComponent(HeroesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should show hero details', async () => {
    fixture.whenStable().then(() => {
      expect(
        fixture.debugElement.nativeElement.querySelector('h2').textContent
      ).toBe(`${component.hero.name.toUpperCase()} Details`);
      expect(
        fixture.debugElement.nativeElement.querySelector('#name').value
      ).toBe(component.hero.name);
      expect(
        fixture.debugElement.nativeElement.querySelector('#id').textContent
      ).toBe(`id: ${component.hero.id}`);
    });
  });
});
