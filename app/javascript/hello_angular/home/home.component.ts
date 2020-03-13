import { Component } from '@angular/core';
import templateString from './home.html';
import { NgFlashMessageService } from 'ng-flash-messages';
import { AppService } from '../app/app.service';
import { MatDialog } from '@angular/material';
import { Router, ActivatedRoute } from '@angular/router';
import { ChartType, ChartOptions } from 'chart.js';
import { Label } from 'ng2-charts';

@Component({
	template: templateString
})
export class HomeComponent {
	constructor(
		private ngFlashMessageService: NgFlashMessageService,
		private appService: AppService,
		public dialog: MatDialog,
		private route: ActivatedRoute,
		private router: Router
	) {}
	pieChartLabels: Label[] = [['ผู้ติดเชื้อ'], ['รักษาหาย'], 'เสียชีวิต'];
	pieChartData: number[] = [0, 0, 0];
	pieChartType: ChartType = 'pie';
	pieChartColors = [
		{
			backgroundColor: ['#FCD35E', '#5EFCAD', '#FC5E71']
		}
	];
	total: any = [];

	ngOnInit() {
		this.dailyTotal();
	}

	dailyTotal() {
		this.appService.all('covids/total').subscribe(
			resp => {
				let value: any = resp;
				this.total = value.data;
				this.pieChartData = [this.total.confirmed, this.total.recovered, this.total.deaths];
			},
			e => {
				this.ngFlashMessageService.showFlashMessage({
					messages: [e.message],
					dismissible: true,
					timeout: 5000,
					type: 'danger'
				});
			}
		);
	}
}
