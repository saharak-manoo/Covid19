import { Component, ViewChild } from '@angular/core';
import templateString from './users.html';
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { ConfirmDialogModel, ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { MatDialog } from '@angular/material';
import { Page } from '../_model/page';
import { User } from '../_model/user';

@Component({
  template: templateString,
  providers: [AppService]
})
export class UsersComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, public dialog: MatDialog) { }
  public datas: any;
  sessions: any;
  loading: boolean = false;
  page = new Page();
  rows = new Array<User>();
  expanded: any = {};
  canRemove: boolean;
  @ViewChild('usersTable', { static: false }) table: any;

  ngOnInit() {
    this.checkSignIn();
    this.loadTable();
    this.canRemoved();
  }

  canRemoved() {
    if (this.sessions.current_user.admin) {
      this.canRemove = true;
    } else {
      this.canRemove = false;
    }
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

  loadTable() {
    this.loading = true;
    this.appService.getDataForPageSide('users', this.page).subscribe(
      resp => {
        this.datas = resp;
        this.page = this.datas.page;
        this.rows = this.datas.users;
        this.loading = false;
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

  search(event) {
    this.page.search = event.target.value.toLowerCase();
    this.loadTable();
  }

  sort(event) {
    let sort = event.sorts[0]
    this.page.sort = sort.prop;
    this.page.order = sort.dir;
    this.loading = true;
    this.loadTable();
  }

  pageChanged(event) {
    this.page.page_now = event.offset
    this.loadTable();
  }

  toggleExpandRow(row) {
    this.table.rowDetail.toggleExpandRow(row);
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