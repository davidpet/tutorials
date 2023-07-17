import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { MyLibModule } from 'my-lib';
import { CommonLibModule } from 'common-lib';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    CommonLibModule,
    MyLibModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
