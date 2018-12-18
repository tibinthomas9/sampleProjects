import {RouterModule, Routes} from "@angular/router";

import {homeViewComponent} from "../home-view/home-view.component";
import {mainViewComponent} from "../main-view/main-view.component";
import {minorViewComponent} from "../minor-view/minor-view.component";

export const HomeRoutes:Routes = [
    // Main redirect
    
    {path: 'home', component: homeViewComponent,
     children: [
      { path: '', redirectTo: 'mainView', pathMatch: 'full' },
      {path: 'mainView', component: mainViewComponent},
      {path: 'minorView', component: minorViewComponent},
         ]
    },


    // Handle all other routes
    
];

export const homeRoutingProviders: any[] = [

];

export const homeRouting = RouterModule.forChild(HomeRoutes);
