import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-second',
  templateUrl: './second.component.html',
  styleUrls: ['./second.component.scss'],
})
export class SecondComponent implements OnInit {
  // The structure is determined by us in the routing table.
  data?: { x: number; y: number; z: number; animationName: string };

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    // As with url params, you can get it as a snapshot or as an observable.
    // NOTE: data is totally separate from paramMap.
    // You cannot specify data members in matrix, path, or query param notation.
    // They are not part of the url and are only part of the routing system.
    this.data = this.route.snapshot.data as {
      x: number;
      y: number;
      z: number;
      animationName: string;
    };
  }
}
