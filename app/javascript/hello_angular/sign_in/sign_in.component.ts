import { Component, OnInit } from '@angular/core';
import templateString from './sign_in.html';
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  template: templateString,
  providers: [AppService]
})
export class SignInComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, private formBuilder: FormBuilder, private route: ActivatedRoute, private router: Router) { }
  public datas: any;
  public sessions: any;
  signInForm: FormGroup;
  returnUrl = '/homes';

  get f() { return this.signInForm.controls; }

  ngOnInit() {
    this.signInForm = this.formBuilder.group({
      email: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  onSubmit() {
    if (this.signInForm.invalid) {
      return;
    }

    this.appService.signIn('users/sign_in', { user: { email: this.f.email.value, password: this.f.password.value } }).subscribe(
      resp => {
        this.datas = resp
        if (this.datas.signed_in) {
          this.router.navigate([this.returnUrl]);
          this.ngFlashMessageService.showFlashMessage({
            messages: ['Sign In success.'],
            dismissible: true,
            timeout: 5000,
            type: 'success'
          });
        } else {
          this.ngFlashMessageService.showFlashMessage({
            messages: ['Email or password worng.'],
            dismissible: true,
            timeout: 5000,
            type: 'danger'
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