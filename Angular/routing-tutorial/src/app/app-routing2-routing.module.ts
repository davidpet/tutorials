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
    // Data is statically passed to the component via the
    // routing system (not the url). One example of how
    // to use this is to configure animation names at the
    // module level like this.
    data: {
      x: 100,
      y: 200,
      z: 300,
      animationName: 'second',
    },
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
