import { ChangeDetectionStrategy, Component, Input, OnChanges, SimpleChanges } from '@angular/core';
import {ChangeDetection} from '../change-detection.interfaxce';

@Component({
  selector: 'app-default-change-detection',
  templateUrl: './default-change-detection.component.html',
  styleUrls: ['./default-change-detection.component.scss'],
  //changeDetection: ChangeDetectionStrategy.OnPush,
  changeDetection: ChangeDetectionStrategy.Default,
})
export class DefaultChangeDetectionComponent implements OnChanges {
  @Input() inValue?: ChangeDetection;
  @Input() inValue2?: number;

  inNumber?: number;

  ngOnChanges(changes: SimpleChanges) {
    console.log(changes);
  }

  applyFieldChange() {
    this.inNumber = this.inNumber || 0;
    this.inNumber++;
  }

  getTransformedValue() {
    if (this.inNumber) {
      return this.inNumber * this.inNumber;
    }
    else {
      return this.inNumber;
    }
  }

  getTransformedObjectValue() {
    if (this.inValue?.x) {
      return this.inValue.x * this.inValue.x;
    }
    else {
      return this.inValue?.x;
    }
  }
}
