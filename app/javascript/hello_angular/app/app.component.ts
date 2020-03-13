import { Component } from '@angular/core';
import templateString from './app.html';
import { NgFlashMessageService } from 'ng-flash-messages';
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from '@angular/router';
import {
	ConfirmDialogModel,
	ConfirmDialogComponent
} from '../confirm_dialog/confirm_dialog.conponent';
import { MatDialog } from '@angular/material';

@Component({
	selector: 'hello-angular',
	template: templateString,
	providers: [AppService]
})
export class AppComponent {
	constructor(
		private ngFlashMessageService: NgFlashMessageService,
		private appService: AppService,
		private route: ActivatedRoute,
		private router: Router,
		public dialog: MatDialog
	) {}
	activeTab: string;
	signInMenu = false;

	ngOnInit() {
		this.router.events.subscribe(event => {
			if (event) {
				this.activeTab = 'homes';
				this.checkSignIn();
			}
		});
	}

	checkSignIn() {
		this.appService.all('covids').subscribe(
			resp => {
				console.log(resp);
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

	activeNavTab(tab) {
		this.activeTab = tab;
	}
}
