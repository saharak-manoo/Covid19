import { Component } from "@angular/core";
import templateString from "./app.html";
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from '@angular/router';
import { ConfirmDialogModel, ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { MatDialog } from '@angular/material';

@Component({
  selector: "hello-angular",
  template: templateString,
  providers: [AppService]
})
export class AppComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, private route: ActivatedRoute, private router: Router, public dialog: MatDialog) { }
  public sessions: {};
  activeTab: string;
  signInMenu = false;

  ngOnInit() {
    this.sessions = {
      signed_in: false
    }
    this.router.events.subscribe(
      (event) => {
        if (event) {
          this.activeTab = 'homes';
          this.checkSignIn();
        }
      });
  }

  checkSignIn() {
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

  activeNavTab(tab) {
    this.activeTab = tab;
  }

  showSignInMenu() {
    this.signInMenu = !this.signInMenu;
  }

  signOut() {
    const message = 'Are you sure you want to do this?';
    const dialogData = new ConfirmDialogModel('Confirm Action', message);
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      maxWidth: '400px',
      data: dialogData
    });

    dialogRef.afterClosed().subscribe(dialogResult => {
      if (dialogResult) {
        this.appService.signOut('users/sign_out').subscribe(
          resp => {
            if (resp) {
              this.ngFlashMessageService.showFlashMessage({
                messages: ["Sign Out success."],
                dismissible: true,
                timeout: 5000,
                type: "success"
              });
            }
            this.checkSignIn();
            this.router.navigate(['homes']);
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
