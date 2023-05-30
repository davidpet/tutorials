import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FirstComponent } from './first/first.component';
import { SecondComponent } from './second/second.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { ChildAComponent } from './child-a/child-a.component';
import { ChildBComponent } from './child-b/child-b.component';

// Promise to return a title asynchronously.
const resolvedChildATitle = () => Promise.resolve('Child B');

const routes: Routes = [
  // Order is more specific to less specific because first
  // match wins.
  {
    path: 'first-component',
    component: FirstComponent,
    // Overwrites the browser title that was statically specified in index.html.
    title: 'First Component',
    // Within FirstComponent, you can have another unnamed
    // outlet and router links that pretend it's the root.
    children: [
      {
        path: 'child-a',
        component: ChildAComponent,
        // Replaces the "First Component" title because we gave a static string.
        // But when the child outlet is empty, it will still be
        // "First Component".
        title: 'Child A',
      },
      {
        path: 'child-b',
        component: ChildBComponent,
        // This is just to demonstrate that the title can be a string or a promise
        // that returns a string (eg. so you can do an async call).
        title: resolvedChildATitle,
      },
    ],
  },
  {
    path: 'second-component',
    component: SecondComponent,
    title: 'Second Component',
  },

  // Default empty path to first component (shows in address bar).
  { path: '', redirectTo: '/first-component', pathMatch: 'full' },

  // Any path that gets to this point is a 404.
  { path: '**', component: PageNotFoundComponent },
];

@NgModule({
  declarations: [
    FirstComponent,
    SecondComponent,
    PageNotFoundComponent,
    ChildAComponent,
    ChildBComponent,
  ],
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
