import { ChangeDetectionStrategy, Component } from '@angular/core';
import { ChangeDetection } from '../change-detection.interfaxce';

@Component({
  selector: 'app-change-detection-host',
  templateUrl: './change-detection-host.component.html',
  styleUrls: ['./change-detection-host.component.scss'],
  changeDetection: ChangeDetectionStrategy.Default,
  //changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ChangeDetectionHostComponent {
  changeDetection: ChangeDetection = {
    x: 0,
    s: '',
    a: [],
    o: {
      f: 0,
      g: [],
      h: {
        i: ''
      }
    }
  };
  boundNumber = 0;

  applyChanges() {
      this.changeDetection.o.f += 1;
      //this.changeDetection = {...this.changeDetection};
  }

  numberChange() {
    this.boundNumber += 1;
  }
}
