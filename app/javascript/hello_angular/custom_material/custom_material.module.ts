import { NgModule } from '@angular/core';
import { MatButtonModule, MatDialogModule } from '@angular/material';

@NgModule({
  imports: [
    MatButtonModule, MatDialogModule
  ],
  exports: [
    MatButtonModule, MatDialogModule
  ]
})
export class CustomMaterialModule {
}