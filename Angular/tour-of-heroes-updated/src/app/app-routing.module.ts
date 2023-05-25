import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HeroesComponent } from './heroes/heroes.component';

// suburl -> component mappings
const routes: Routes = [{ path: 'heroes', component: HeroesComponent }];

@NgModule({
  // make & import a module that maps suburls uner root of implication
  imports: [RouterModule.forRoot(routes)],
  // make symbols like <routing-outlet> available in the app
  exports: [RouterModule],
})
export class AppRoutingModule {}
