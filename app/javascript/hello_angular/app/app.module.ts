import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { enableProdMode } from '@angular/core';
import { AppComponent } from './app.component';
import { HomeComponent } from '../home/home.component';
import { RouterModule, Routes } from '@angular/router';
import { APP_BASE_HREF } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { FormsModule } from '@angular/forms';
import { NgxPaginationModule } from 'ngx-pagination';
import { NgFlashMessagesModule } from 'ng-flash-messages';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { ReactiveFormsModule } from '@angular/forms';
import { MatMenuModule } from '@angular/material/menu';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule, MatInputModule } from '@angular/material';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NgbPaginationModule, NgbAlertModule } from '@ng-bootstrap/ng-bootstrap';
import { ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { CustomMaterialModule } from '../custom_material/custom_material.module';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatButtonModule } from '@angular/material/button';

enableProdMode();

const appRoutes: Routes = [
	{ path: '', component: HomeComponent },
	{ path: 'homes', component: HomeComponent }
];

@NgModule({
	declarations: [AppComponent, HomeComponent, ConfirmDialogComponent],
	imports: [
		BrowserModule,
		HttpClientModule,
		NgxDatatableModule,
		NgxPaginationModule,
		MatButtonModule,
		FormsModule,
		MatTableModule,
		MatPaginatorModule,
		CustomMaterialModule,
		NgFlashMessagesModule.forRoot(),
		TooltipModule.forRoot(),
		ReactiveFormsModule,
		MatMenuModule,
		MatDatepickerModule,
		MatFormFieldModule,
		MatInputModule,
		NgbModule,
		NgbPaginationModule,
		NgbAlertModule,
		RouterModule.forRoot(appRoutes, { useHash: true })
	],
	providers: [{ provide: APP_BASE_HREF, useValue: '/' }],
	entryComponents: [ConfirmDialogComponent],
	bootstrap: [AppComponent]
})
export class AppModule {}
