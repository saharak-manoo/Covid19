import { Component, ViewChild } from '@angular/core'
import templateString from './map.html'
import { NgFlashMessageService } from 'ng-flash-messages'
import { AppService } from '../app/app.service'
import { MatDialog } from '@angular/material'
import { Router, ActivatedRoute } from '@angular/router'
import { ChartType, ChartOptions } from 'chart.js'
import { Label } from 'ng2-charts'
import { AppComponent } from '../app/app.component'
import { LoadingBarService } from '@ngx-loading-bar/core'
import { MatPaginator } from '@angular/material/paginator'
import { MatTableDataSource } from '@angular/material/table'
import { MatSort } from '@angular/material/sort'

@Component({
  template: templateString
})
export class MapComponent {
  constructor(
    private ngFlashMessageService: NgFlashMessageService,
    private appService: AppService,
    public dialog: MatDialog,
    private route: ActivatedRoute,
    private router: Router,
    private app: AppComponent,
    private loadingBar: LoadingBarService
  ) {}
  latitude: number = 13.7530066
  longitude: number = 100.4960144
  cases: any = []
  hospitals: any = []
  safeZones: any = []

  ngOnInit() {
    this.getLocation()
    this.loadCasesThai()
    this.loadHospital()
    this.loadSafeZone()
  }

  getLocation() {
    this.app.getPosition().then((pos) => {
      this.latitude = pos.lat
      this.longitude = pos.lng
      this.loadCasesThai()
      this.loadHospital()
    })
  }

  loadCasesThai() {
    this.appService
      .getWithParams('api/covids/thailand_case_by_location', { latitude: this.latitude, longitude: this.longitude })
      .subscribe(
        (resp) => {
          let response: any = resp
          this.cases = response.data
        },
        (e) => {
          this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
        }
      )
  }

  loadHospital() {
    this.appService
      .getWithParams('api/covids/hospital_by_location', { latitude: this.latitude, longitude: this.longitude })
      .subscribe(
        (resp) => {
          let response: any = resp
          this.hospitals = response.data
        },
        (e) => {
          this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
        }
      )
  }

  loadSafeZone() {
    this.appService.get('api/covids/safe_zone').subscribe(
      (resp) => {
        let response: any = resp
        this.safeZones = response.data
      },
      (e) => {
        this.app.openSnackBar(e.message, 'Close', 'red-snackbar')
      }
    )
  }
}
