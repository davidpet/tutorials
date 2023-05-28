import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { TestStateLeakageComponent } from './test-state-leakage/test-state-leakage.component';
import { ParentComponent } from './inputs-outputs/parent/parent.component';
import { ChildComponent } from './inputs-outputs/child/child.component';

@NgModule({
  declarations: [
    AppComponent,
    TestStateLeakageComponent,
    ParentComponent,
    ChildComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
