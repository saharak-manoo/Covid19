import { Component } from '@angular/core';
import templateString from './show_user.html';
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from "@angular/router";
import { ConfirmDialogModel, ConfirmDialogComponent } from '../confirm_dialog/confirm_dialog.conponent';
import { MatDialog } from '@angular/material';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { User } from '../_model/user';

@Component({
  template: templateString,
  providers: [AppService]
})
export class ShowUserComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, public dialog: MatDialog, private formBuilder: FormBuilder, private route: ActivatedRoute, private router: Router) { }
  public datas: any;
  public user: any;
  public sessions: any;
  public id: string;
  canUpdate: boolean;
  userForm: FormGroup;
  submitted = false;
  returnUrl = '/users';

  ngOnInit() {
    this.checkSignIn();
    this.loadUser();

    const regexPattern = /\-?\d*\.?\d{1,2}/;
    this.userForm = this.formBuilder.group({
      email: ['', Validators.required],
      first_name: ['', Validators.required],
      last_name: ['', Validators.required],
      phone_number: ['', Validators.pattern(regexPattern)],
    });
  }

  canUpdated() {
    if (this.sessions.current_user.admin) {
      this.canUpdate = true;
    } else {
      this.canUpdate = this.sessions.current_user.admin
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

  loadUser() {
    this.route.paramMap.subscribe(params => {
      this.id = params.get('id')
    })

    this.datas = {
      user: { photo: null },
    }

    this.appService.find('users', this.id).subscribe(
      resp => {
        this.datas = resp;
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

  onSelectFile(event: any) {
    event.preventDefault();

    let element: HTMLElement = document.getElementById('photo') as HTMLElement;
    element.click();
  }

  onFileChange(event) {
    if (event.target.files && event.target.files[0]) {
      const file = event.target.files[0];
      this.datas.photo = file;

      const reader = new FileReader();
      reader.onload = e => this.datas.photo_url = reader.result;

      reader.readAsDataURL(file);
    }
  }

  onSubmit() {
    if (this.userForm.invalid) {
      return;
    }

    const formData = new FormData();
    formData.append('user[email]', this.datas.user.email);
    formData.append('user[first_name]', this.datas.user.first_name);
    formData.append('user[last_name]', this.datas.user.last_name);
    formData.append('user[phone_number]', this.datas.user.phone_number);
    if (this.datas.photo) {
      formData.append('user[photo]', this.datas.photo);
    }

    this.appService.update('users', this.id, formData).subscribe(
      resp => {
        this.datas = resp
        if (this.datas.updated) {
          this.router.navigate([this.returnUrl]);
          this.ngFlashMessageService.showFlashMessage({
            messages: ['Update user success.'],
            dismissible: true,
            timeout: 5000,
            type: 'success'
          });
        }
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
}