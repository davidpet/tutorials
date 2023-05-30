import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FirstComponent } from './first/first.component';
import { SecondComponent } from './second/second.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';

const routes: Routes = [
  // Order is more specific to less specific because first
  // match wins.
  { path: 'first-component', component: FirstComponent },
  { path: 'second-component', component: SecondComponent },

  // Any path that gets to this point is a 404.
  { path: '**', component: PageNotFoundComponent },
];

@NgModule({
  declarations: [FirstComponent, SecondComponent, PageNotFoundComponent],
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
