import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { NgxSpinnerModule } from "ngx-spinner";

import { AppComponent } from './app.component';
import { MyLibModule } from 'my-lib';
import { CommonLibModule } from 'common-lib';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserAnimationsModule,
    BrowserModule,
    CommonLibModule,
    MyLibModule,
    NgxSpinnerModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
