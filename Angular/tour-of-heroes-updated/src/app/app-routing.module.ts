import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HeroesComponent } from './heroes/heroes.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { HeroDetailComponent } from './hero-detail/hero-detail.component';

// suburl -> component mappings
const routes: Routes = [
  { path: 'heroes', component: HeroesComponent },
  { path: 'dashboard', component: DashboardComponent },
  // parameterized route
  { path: 'detail/:id', component: HeroDetailComponent },
  // default root (auto-navigated from root, changes browser url bar too)
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
];

@NgModule({
  // make & import a module that maps suburls uner root of implication
  imports: [RouterModule.forRoot(routes)],
  // make symbols like <routing-outlet> available in the app
  exports: [RouterModule],
})
export class AppRoutingModule {}
