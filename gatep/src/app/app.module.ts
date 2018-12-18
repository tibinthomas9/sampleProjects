import { NgModule }      from '@angular/core';
import {RouterModule} from "@angular/router";
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent }  from './app.component';
import {HttpModule} from "@angular/http";
import {ROUTES, appRoutingProviders} from "./app.routes";
import {LocationStrategy, HashLocationStrategy} from '@angular/common';
// App views
import {LoginViewModule} from "../views/login-view/login-view.module";
import {HomeViewModule} from "../views/home-view/home-view.module";


@NgModule({
  imports     : [

        // Angular modules
        BrowserModule,
        HttpModule,

        // Views
        LoginViewModule,
        HomeViewModule,


        RouterModule.forRoot(ROUTES)
    ],
    providers   : [{provide: LocationStrategy, useClass: HashLocationStrategy},appRoutingProviders],
   
  declarations: [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
