import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AppRouting2Module } from './app-routing2.module';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [AppComponent],
  // Feature models before app routing module.
  // That way, more specific routes will hit before
  // things like 404.
  // NOTE: it still needs to be forChild() instead of forRoot()
  // but the routes will run first and won't be relative.
  imports: [BrowserModule, AppRouting2Module, AppRoutingModule, FormsModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
