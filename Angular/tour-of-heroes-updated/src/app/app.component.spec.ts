import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { Router } from '@angular/router';
import { AppComponent } from './app.component';
import { HeroesComponent } from './heroes/heroes.component';
import { FormsModule } from '@angular/forms';
import { HeroDetailComponent } from './hero-detail/hero-detail.component';
import { MessagesComponent } from './messages/messages.component';
import { AppRoutingModule } from './app-routing.module';

describe('AppComponent', () => {
  let router: Router;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [
        AppComponent,
        HeroesComponent,
        HeroDetailComponent,
        MessagesComponent,
      ],
      imports: [AppRoutingModule, FormsModule, RouterTestingModule],
    });

    router = TestBed.inject(Router);
  });

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

  it('should not render app heroes component from root', async () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    await fixture.whenStable();

    const childComponent =
      fixture.debugElement.nativeElement.querySelector('.heroes');
    expect(childComponent).toBeFalsy();
  });

  it('should render app heroes component from /heroes', async () => {
    const fixture = TestBed.createComponent(AppComponent);
    router.navigate(['/heroes']);
    fixture.detectChanges();
    await fixture.whenStable();

    const childComponent =
      fixture.debugElement.nativeElement.querySelector('.heroes');
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
