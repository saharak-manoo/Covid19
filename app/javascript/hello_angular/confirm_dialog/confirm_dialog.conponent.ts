import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Component, OnInit, Inject } from '@angular/core';
import templateString from "./confirm_dialog.html";

@Component({
  selector: 'app-confirm-dialog',
  template: templateString
})
export class ConfirmDialogComponent implements OnInit {
  title: string;
  message: string;

  constructor(public dialogRef: MatDialogRef<ConfirmDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ConfirmDialogModel) {
    this.title = data.title;
    this.message = data.message;
  }

  ngOnInit() {
  }

  onConfirm(): void {
    this.dialogRef.close(true);
  }

  onDismiss(): void {
    this.dialogRef.close(false);
  }
}

export class ConfirmDialogModel {
  constructor(public title: string, public message: string) { }
}
