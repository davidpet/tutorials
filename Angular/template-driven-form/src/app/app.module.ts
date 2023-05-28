import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { HeroFormComponent } from './hero-form/hero-form.component';
import { ForbiddenValidatorDirective } from './forbidden-name.directive';

@NgModule({
  imports: [BrowserModule, CommonModule, FormsModule],
  declarations: [AppComponent, HeroFormComponent, ForbiddenValidatorDirective],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
