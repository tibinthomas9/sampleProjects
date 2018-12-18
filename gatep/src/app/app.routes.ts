import {Routes,RouterModule} from "@angular/router";
import {loginViewComponent} from "../views/login-view/login-view.component";
import {homeViewComponent} from "../views/home-view/home-view.component";
import {mainViewComponent} from "../views/main-view/main-view.component";
import {minorViewComponent} from "../views/minor-view/minor-view.component";

export const ROUTES:Routes = [
    // Main redirect
    {path: '', redirectTo: 'login', pathMatch: 'full'},

    // App views
    {path: 'login', component: loginViewComponent},

    // Handle all other routes
    {path: '**',    component: loginViewComponent }
];

export const appRoutingProviders: any[] = [

];

export const routing = RouterModule.forRoot(ROUTES);
