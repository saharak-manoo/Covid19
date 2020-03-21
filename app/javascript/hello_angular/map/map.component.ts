import { Component, ViewChild } from '@angular/core';
import templateString from './map.html';
import { NgFlashMessageService } from 'ng-flash-messages';
import { AppService } from '../app/app.service';
import { MatDialog } from '@angular/material';
import { Router, ActivatedRoute } from '@angular/router';
import { ChartType, ChartOptions } from 'chart.js';
import { Label } from 'ng2-charts';
import { AppComponent } from '../app/app.component';
import { LoadingBarService } from '@ngx-loading-bar/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';

@Component({
	template: templateString
})
export class MapComponent {
	constructor(
		private ngFlashMessageService: NgFlashMessageService,
		private appService: AppService,
		public dialog: MatDialog,
		private route: ActivatedRoute,
		private router: Router,
		private app: AppComponent,
		private loadingBar: LoadingBarService
	) {}
}
