import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable, map } from 'rxjs';

@Component({
  selector: 'app-first',
  templateUrl: './first.component.html',
  styleUrls: ['./first.component.scss'],
})
export class FirstComponent implements OnInit {
  // We could get ID through an input binding or through the router.
  @Input() id?: number;

  id$?: Observable<string>;

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    if (this.id === undefined) {
      // Snapshot gives the ID at the time of page load.
      this.id = Number(this.route.snapshot.paramMap.get('id'));
      // You can also subscribe to observable instead.
      // If you use router.navigate() and only the id is different,
      // the component will not reload, but the observable will
      // emit.
      // If you change the url id and hit Enter instead, the
      // component will reload.
      this.id$ = this.route.paramMap.pipe(
        map((paramMap) => paramMap.get('id') ?? '')
      );
    }
  }
}
