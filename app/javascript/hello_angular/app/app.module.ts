import { BrowserModule } from '@angular/platform-browser';
import { environment } from '../environment';
import { NgModule } from '@angular/core';
import { enableProdMode } from '@angular/core';
import { AppComponent } from './app.component';
import { HomeComponent } from '../home/home.component';
import { MapComponent } from '../map/map.component';
import { RouterModule, Routes } from '@angular/router';
import { APP_BASE_HREF } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { FormsModule } from '@angular/forms';
import { NgxPaginationModule } from 'ngx-pagination';
import { NgFlashMessagesModule } from 'ng-flash-messages';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { ReactiveFormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NgbPaginationModule, NgbAlertModule } from '@ng-bootstrap/ng-bootstrap';
import { ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { CustomMaterialModule } from '../custom_material/custom_material.module';
import { ChartsModule } from 'ng2-charts';
import {
	MatAutocompleteModule,
	MatButtonModule,
	MatButtonToggleModule,
	MatCardModule,
	MatCheckboxModule,
	MatChipsModule,
	MatDatepickerModule,
	MatDialogModule,
	MatExpansionModule,
	MatGridListModule,
	MatIconModule,
	MatInputModule,
	MatListModule,
	MatMenuModule,
	MatNativeDateModule,
	MatPaginatorModule,
	MatProgressBarModule,
	MatProgressSpinnerModule,
	MatRadioModule,
	MatRippleModule,
	MatSelectModule,
	MatSidenavModule,
	MatSliderModule,
	MatSlideToggleModule,
	MatSnackBarModule,
	MatSortModule,
	MatTableModule,
	MatTabsModule,
	MatToolbarModule,
	MatTooltipModule,
	MatStepperModule,
	MatFormFieldModule
} from '@angular/material';
import { AgmCoreModule } from '@agm/core';
import { LoadingBarHttpClientModule } from '@ngx-loading-bar/http-client';
import { FlexLayoutModule } from '@angular/flex-layout';
import { CountToModule } from 'angular-count-to';

enableProdMode();

@NgModule({
	exports: [
		MatAutocompleteModule,
		MatButtonModule,
		MatButtonToggleModule,
		MatCardModule,
		MatCheckboxModule,
		MatChipsModule,
		MatStepperModule,
		MatDatepickerModule,
		MatDialogModule,
		MatExpansionModule,
		MatGridListModule,
		MatIconModule,
		MatInputModule,
		MatListModule,
		MatMenuModule,
		MatNativeDateModule,
		MatPaginatorModule,
		MatProgressBarModule,
		MatProgressSpinnerModule,
		MatRadioModule,
		MatRippleModule,
		MatSelectModule,
		MatSidenavModule,
		MatSliderModule,
		MatSlideToggleModule,
		MatSnackBarModule,
		MatSortModule,
		MatTableModule,
		MatTabsModule,
		MatToolbarModule,
		MatTooltipModule,
		MatFormFieldModule
	]
})
export class MaterialModule {}

const appRoutes: Routes = [
	{ path: '', component: HomeComponent },
	{ path: 'homes', component: HomeComponent },
	{ path: 'map', component: MapComponent }
];

@NgModule({
	declarations: [AppComponent, HomeComponent, ConfirmDialogComponent, MapComponent],
	imports: [
		BrowserModule,
		HttpClientModule,
		NgxDatatableModule,
		NgxPaginationModule,
		FormsModule,
		CustomMaterialModule,
		NgFlashMessagesModule.forRoot(),
		TooltipModule.forRoot(),
		ReactiveFormsModule,
		NgbModule,
		NgbPaginationModule,
		NgbAlertModule,
		RouterModule.forRoot(appRoutes, { useHash: true }),
		ChartsModule,
		MaterialModule,
		LoadingBarHttpClientModule,
		FlexLayoutModule,
		CountToModule,
		AgmCoreModule.forRoot({
			apiKey: environment.googleApiKey
		})
	],
	providers: [{ provide: APP_BASE_HREF, useValue: '/' }],
	entryComponents: [ConfirmDialogComponent],
	bootstrap: [AppComponent]
})
export class AppModule {}
