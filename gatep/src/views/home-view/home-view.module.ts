import {NgModule} from "@angular/core";
import {RouterModule} from "@angular/router";
import {BrowserModule} from "@angular/platform-browser";
import {HomeRoutes, homeRoutingProviders} from "./home.routes";
import {homeViewComponent} from "./home-view.component";

import {MainViewModule} from "../main-view/main-view.module";
import {MinorViewModule} from "../minor-view/minor-view.module";

// App modules/components
import {NavigationModule} from "../common/navigation/navigation.module";
import {FooterModule} from "../common/footer/footer.module";
import {TopnavbarModule} from "../common/topnavbar/topnavbar.module";

@NgModule({
    declarations: [homeViewComponent],
    imports     : [
    BrowserModule,

    MainViewModule,
    MinorViewModule,
    // common modules
    NavigationModule,
    FooterModule,
    TopnavbarModule,

    RouterModule.forChild(HomeRoutes)
    ],
})

export class HomeViewModule {}