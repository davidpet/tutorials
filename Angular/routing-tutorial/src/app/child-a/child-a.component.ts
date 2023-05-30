import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-child-a',
  templateUrl: './child-a.component.html',
  styleUrls: ['./child-a.component.scss'],
})
export class ChildAComponent implements OnInit {
  id = -1000;

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    // We can just take the params we're interested in and ignore
    // the rest.  We could check for existence, use observable
    // instead, etc. as needed.
    // NOTE: This is the same way you get params that are part
    // of the URL, but not the same way you get query params.
    this.id = Number(this.route.snapshot.paramMap.get('id'));
  }
}
