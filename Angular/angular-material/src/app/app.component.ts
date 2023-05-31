import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  showAddressForm = true;
  showTable = false;

  title = 'angular-material';

  toggleTable() {
    this.showTable = !this.showTable;
  }
}
