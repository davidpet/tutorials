import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AppRouting2RoutingModule } from './app-routing2-routing.module';

// This simulates having another "feature module" for the app.
@NgModule({
  declarations: [],
  imports: [CommonModule, AppRouting2RoutingModule],
})
export class AppRouting2Module {}
