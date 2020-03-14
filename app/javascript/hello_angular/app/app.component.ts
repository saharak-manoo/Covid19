import { Component } from '@angular/core';
import templateString from './app.html';
import { NgFlashMessageService } from 'ng-flash-messages';
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from '@angular/router';
import { MatSnackBar, ErrorStateMatcher } from '@angular/material';
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
		public dialog: MatDialog,
		public snackBar: MatSnackBar
	) {}

	activeTab: string;
	signInMenu = false;

	ngOnInit() {}

	openSnackBar(message, action, className) {
		this.snackBar.open(message, action, {
			duration: 5000,
			panelClass: [className],
			verticalPosition: 'top',
			horizontalPosition: 'right'
		});
	}
}
