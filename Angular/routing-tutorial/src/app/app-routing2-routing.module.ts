import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SecondComponent } from './second/second.component';

const routes: Routes = [
  {
    // Path is relative to whatever path the app routing module
    // loads this module for.
    path: '',
    component: SecondComponent,
    title: 'Second Component',
  },
];

@NgModule({
  declarations: [SecondComponent],
  // Use forChild() instead of forRoot() here because this is
  // a feature routing module and not the app routing module.
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AppRouting2RoutingModule {}
