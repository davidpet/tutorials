import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router, UrlSegment } from '@angular/router';
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

  constructor(private route: ActivatedRoute, private router: Router) {}

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
      // If you use router.navigate() and only the id and/or child
      // route are different, it will emit but not reload because
      // the primary outlet is not changed.
      this.id$ = this.route.paramMap.pipe(
        map((paramMap) => paramMap.get('id') ?? '')
      );
    }
  }

  navigateToA() {
    // takes an array of URL segments
    // The routerLink version automatically made it relative, but
    // here you have to do a little extra to make that happen.

    // Note that you can pass in whatever you want as the params
    // and none of them had to be specified in the router.  This
    // will use matrix url syntax instead of url path syntax for
    // the params. This is NOT INTRECHANGEABLE WITH QUERYPARAMS.
    // It does allow for optional values that you may or may not
    // specify.
    // http://localhost:55485/first-component/42/child-a;id=1000;foo=whocares
    this.router.navigate(['child-a', { id: 1000, foo: 'whocares' }], {
      relativeTo: this.route,
    });
  }

  // This is needed for the styling and aria stuff since they
  // don't support relativeTo like above.
  getchildAUrl() {
    const url = [...this.route.snapshot.url];
    url.push(new UrlSegment('child-a', {}));

    return url.map((seg) => seg.path).join('/');
  }

  // for styling
  isActive(): boolean {
    return this.router.isActive(this.getchildAUrl(), false);
  }

  //for aria
  isCurrent(): string {
    return this.router.isActive(this.getchildAUrl(), false) ? 'page' : '';
  }
}
