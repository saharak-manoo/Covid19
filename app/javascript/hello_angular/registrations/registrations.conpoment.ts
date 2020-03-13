import { Component } from '@angular/core';
import templateString from './registrations.html';
import { NgFlashMessageService } from "ng-flash-messages";
import { AppService } from '../app/app.service';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  template: templateString,
  providers: [AppService]
})
export class RegistrationsComponent {
  constructor(private ngFlashMessageService: NgFlashMessageService, private appService: AppService, private formBuilder: FormBuilder, private route: ActivatedRoute, private router: Router) { }
  public datas: any;
  user: any;
  public sessions: any;
  signUpForm: FormGroup;
  returnUrl = '/homes';

  get f() { return this.signUpForm.controls; }

  ngOnInit() {
    this.newUser();
    const regexPattern = /\-?\d*\.?\d{1,2}/;
    this.signUpForm = this.formBuilder.group({
      email: ['', Validators.required],
      password: ['', Validators.minLength(6)],
      password_confirmation: ['', Validators.minLength(6)],
      first_name: ['', Validators.required],
      last_name: ['', Validators.required],
      phone_number: ['', Validators.pattern(regexPattern)],
    }, { validator: this.checkPasswords });
  }

  newUser() {
    this.user = {
      photo: null,
    }
    this.appService.get('users/sign_in').subscribe(
      resp => {
        this.user = resp;
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

  checkPasswords(group: FormGroup) {
    let pass = group.controls.password.value;
    let confirmPass = group.controls.password_confirmation.value;

    return pass === confirmPass ? null : { notSame: true }
  }

  onSelectFile(event: any) {
    event.preventDefault();

    let element: HTMLElement = document.getElementById('photo') as HTMLElement;
    element.click();
  }

  onFileChange(event) {
    if (event.target.files && event.target.files[0]) {
      const file = event.target.files[0];
      this.user.photo = file;

      const reader = new FileReader();
      reader.onload = e => this.user.photo_url = reader.result;

      reader.readAsDataURL(file);
    }
  }

  onSubmit() {
    if (this.signUpForm.invalid) {
      return;
    }

    const formData = new FormData();
    formData.append('user[email]', this.user.email);
    formData.append('user[password]', this.user.password);
    formData.append('user[first_name]', this.user.first_name);
    formData.append('user[last_name]', this.user.last_name);
    formData.append('user[phone_number]', this.user.phone_number);
    if (this.user.photo) { formData.append('user[photo]', this.user.photo); }

    this.appService.create('users', formData).subscribe(
      resp => {
        this.datas = resp
        if (this.datas.created) {
          this.router.navigate([this.returnUrl]);
          this.ngFlashMessageService.showFlashMessage({
            messages: ['Sign up and sign in success.'],
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