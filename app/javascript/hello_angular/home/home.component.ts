import { Component } from '@angular/core';
import templateString from './home.html';
import { User } from '../_model/user';
import { ConfigPagination } from '../_model/config-pagination';
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { ConfirmDialogModel, ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { MatDialog } from '@angular/material';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  template: templateString
})
export class HomeComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, public dialog: MatDialog, private route: ActivatedRoute, private router: Router) { }
  public datas: any;
  public sessions: any;
  configPagination = new ConfigPagination();
  search: string;
  limit: number = 8;
  params: any;
  pageNow: number;

  ngOnInit() {
    this.loadTable();
    this.checkSignIn();
  }

  loadTable() {
    this.pageNow = !this.configPagination ? 1 : this.configPagination.currentPage;
    let offset = this.pageNow == 1 ? 0 : (this.pageNow - 1) * this.limit;
    this.params = {
      search: this.search || '',
      limit: this.limit,
      offset: isNaN(offset) ? 0 : offset
    }
    this.datas = {
      users: new Array<User>()
    }
    this.appService.getDataForPageSide('users', this.params).subscribe(
      resp => {
        this.datas = resp;
        this.configPagination = {
          itemsPerPage: this.params.limit,
          currentPage: this.pageNow,
          totalItems: this.datas.page.total
        };
      }, e => {
        this.ngFlashMessageService.showFlashMessage({
          messages: [e.message],
          dismissible: true,
          timeout: 5000,
          type: 'danger'
        });
      }
    )
  }

  checkSignIn() {
    this.sessions = {
      current_user: new Array<User>()
    }
    this.appService.all('users/check_sign_in').subscribe(
      resp => {
        this.sessions = resp;
      }, e => {
        this.ngFlashMessageService.showFlashMessage({
          messages: [e.message],
          dismissible: true,
          timeout: 5000,
          type: 'danger'
        });
      }
    )
  }

  searchUser(event) {
    this.search = event.target.value.toLowerCase();
    this.loadTable();
  }

  pageChanged(event) {
    this.configPagination.currentPage = event;
    this.loadTable();
  }

  removeUser(id) {
    const message = 'Are you sure you want to do this?';
    const dialogData = new ConfirmDialogModel('Confirm Action', message);
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      maxWidth: '400px',
      data: dialogData
    });

    dialogRef.afterClosed().subscribe(dialogResult => {
      if (dialogResult) {
        this.appService.delete('users', id).subscribe(
          resp => {
            this.ngFlashMessageService.showFlashMessage({
              messages: ['Delete success.'],
              dismissible: true,
              timeout: 5000,
              type: 'success'
            });
            this.loadTable()
          }, e => {
            this.ngFlashMessageService.showFlashMessage({
              messages: [e.message],
              dismissible: true,
              timeout: 5000,
              type: 'danger'
            });
          }
        );
      }
    });
  }
}