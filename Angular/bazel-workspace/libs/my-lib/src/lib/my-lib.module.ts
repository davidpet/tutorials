import { NgModule } from '@angular/core';
import { MyLibComponent } from './my-lib.component';
import { CommonLibModule } from 'common-lib';



@NgModule({
  declarations: [
    MyLibComponent
  ],
  imports: [
    CommonLibModule,
  ],
  exports: [
    MyLibComponent
  ]
})
export class MyLibModule { }
