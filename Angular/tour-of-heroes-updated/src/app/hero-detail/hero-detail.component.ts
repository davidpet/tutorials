import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HeroService } from '../hero.service';
import { Subject, takeUntil } from 'rxjs';
import { Hero } from '../hero';

@Component({
  selector: 'app-hero-detail',
  templateUrl: './hero-detail.component.html',
  styleUrls: ['./hero-detail.component.css'],
})
export class HeroDetailComponent implements OnInit, OnDestroy {
  private destroy$ = new Subject<void>();

  hero?: Hero;

  constructor(
    private route: ActivatedRoute, // to get ID parameter
    private heroService: HeroService
  ) {}

  ngOnInit() {
    this.getHero();
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

  getHero(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.heroService
      .getHero(id)
      .pipe(takeUntil(this.destroy$))
      .subscribe((hero) => (this.hero = hero));
  }
}
