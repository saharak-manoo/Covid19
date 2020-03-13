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
	localLastUpdated: string = 'กำหลังโหลด...';
	globleLastUpdated: string = 'กำหลังโหลด...';
	pieChartOptions: ChartOptions = {
		responsive: true,
		legend: {
			position: 'bottom'
		}
	};
	pieChartDataLocal: number[] = [0, 0, 0];
	pieChartLabels: Label[] = [['ผู้ติดเชื้อ'], ['กำลังอยู่ในการรักษา'], ['รักษาหาย'], 'เสียชีวิต'];
	pieChartData: number[] = [0, 0, 0];
	pieChartType: ChartType = 'pie';
	pieChartColors = [
		{
			backgroundColor: ['#FCD35E', '#BFFD59', '#5EFCAD', '#FC5E71']
		}
	];
	totalLocal: any = {
		confirmed: 0,
		healings: 0,
		recovered: 0,
		deaths: 0
	};
	total: any = {
		confirmed: 0,
		healings: 0,
		recovered: 0,
		deaths: 0
	};
	barChartOptions: ChartOptions = {
		responsive: true,
		scales: {
			xAxes: [
				{
					ticks: {
						beginAtZero: true
					}
				}
			],
			yAxes: [
				{
					ticks: {
						beginAtZero: true
					}
				}
			]
		}
	};
	barChartDataLocal: any = [
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'ผู้ติดเชื้อ' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'กำลังอยู่ในการรักษา' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'รักษาหายแล้ว' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'เสียชีวิต' }
	];
	barChartLabels: Label[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
	barChartType: ChartType = 'bar';
	barChartData: any = [
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'ผู้ติดเชื้อ' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'กำลังอยู่ในการรักษา' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'รักษาหายแล้ว' },
		{ data: [0, 0, 0, 0, 0, 0, 0], label: 'เสียชีวิต' }
	];
	barChartColors = [
		{
			backgroundColor: '#FCD35E'
		},
		{
			backgroundColor: '#BFFD59'
		},
		{
			backgroundColor: '#5EFCAD'
		},
		{
			backgroundColor: '#FC5E71'
		}
	];

	ngOnInit() {
		this.loadData();

		setInterval(() => {
			this.loadData();
		}, 1000 * 60);
	}

	loadData() {
		this.dailyTotalLocal();
		this.countryRetroact();
		this.dailyTotal();
		this.retroact();
	}

	dailyTotalLocal() {
		this.appService.all('covids/country').subscribe(
			resp => {
				let response: any = resp;
				this.localLastUpdated = response.data.last_updated;
				this.totalLocal = response.data;
				this.pieChartDataLocal = [
					this.totalLocal.confirmed,
					this.totalLocal.healings,
					this.totalLocal.recovered,
					this.totalLocal.deaths
				];
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

	countryRetroact() {
		this.appService.all('covids/country_retroact').subscribe(
			resp => {
				let response: any = resp;
				this.barChartLabels = Object.keys(response.data);
				Object.keys(response.data).forEach((key, index) => {
					this.barChartDataLocal[0].data[index] = response.data[key].confirmed;
					this.barChartDataLocal[1].data[index] = response.data[key].healings;
					this.barChartDataLocal[2].data[index] = response.data[key].recovered;
					this.barChartDataLocal[3].data[index] = response.data[key].deaths;
				});
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

	dailyTotal() {
		this.appService.all('covids/total').subscribe(
			resp => {
				let response: any = resp;
				this.globleLastUpdated = response.data.last_updated;
				this.total = response.data;
				this.pieChartData = [
					this.total.confirmed,
					this.total.healings,
					this.total.recovered,
					this.total.deaths
				];
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

	retroact() {
		this.appService.all('covids/retroact').subscribe(
			resp => {
				let response: any = resp;
				this.barChartLabels = Object.keys(response.data);
				Object.keys(response.data).forEach((key, index) => {
					this.barChartData[0].data[index] = response.data[key].confirmed;
					this.barChartData[1].data[index] = response.data[key].healings;
					this.barChartData[2].data[index] = response.data[key].recovered;
					this.barChartData[3].data[index] = response.data[key].deaths;
				});
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
