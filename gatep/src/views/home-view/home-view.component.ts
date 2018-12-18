import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'app',
    templateUrl: 'home-view.template.html'
})
export class homeViewComponent {
   constructor(private route: ActivatedRoute) {}
 }