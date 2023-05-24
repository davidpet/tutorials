import { TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';
import { HeroesComponent } from './heroes/heroes.component';
import { FormsModule } from '@angular/forms';
import { HeroDetailComponent } from './hero-detail/hero-detail.component';
import { MessagesComponent } from './messages/messages.component';

describe('AppComponent', () => {
  beforeEach(() =>
    TestBed.configureTestingModule({
      declarations: [
        AppComponent,
        HeroesComponent,
        HeroDetailComponent,
        MessagesComponent,
      ],
      imports: [FormsModule],
    })
  );

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have as title 'Tour of Heroes`, () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app.title).toEqual('Tour of Heroes');
  });

  it('should render title', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain(
      'Tour of Heroes'
    );
  });

  it('should render app heroes component', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const childComponent =
      fixture.debugElement.nativeElement.querySelector('app-heroes');
    expect(childComponent).toBeTruthy();
  });

  it('should render messages component', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const childComponent =
      fixture.debugElement.nativeElement.querySelector('app-messages');
    expect(childComponent).toBeTruthy();
  });
});
