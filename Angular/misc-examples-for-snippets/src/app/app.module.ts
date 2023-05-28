import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { TestStateLeakageComponent } from './test-state-leakage/test-state-leakage.component';

@NgModule({
  declarations: [
    AppComponent,
    TestStateLeakageComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
