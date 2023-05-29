import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { TestStateLeakageComponent } from './test-state-leakage/test-state-leakage.component';
import { ParentComponent } from './inputs-outputs/parent/parent.component';
import { ChildComponent } from './inputs-outputs/child/child.component';
import { DefaultChangeDetectionComponent } from './change-detection/default-change-detection/default-change-detection.component';
import { ChangeDetectionHostComponent } from './change-detection/change-detection-host/change-detection-host.component';

@NgModule({
  declarations: [
    AppComponent,
    TestStateLeakageComponent,
    ParentComponent,
    ChildComponent,
    DefaultChangeDetectionComponent,
    ChangeDetectionHostComponent
  ],
  imports: [
    BrowserModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
