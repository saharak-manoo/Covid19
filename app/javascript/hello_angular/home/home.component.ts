import { Component, ViewChild } from '@angular/core'
import templateString from './home.html'
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
export class HomeComponent {
  constructor(
    private ngFlashMessageService: NgFlashMessageService,
    private appService: AppService,
    public dialog: MatDialog,
    private route: ActivatedRoute,
    private router: Router,
    private app: AppComponent,
    private loadingBar: LoadingBarService
  ) {}
  localLastUpdated: string = 'กำหลังโหลด...'
  globleLastUpdated: string = 'กำหลังโหลด...'
  pieChartOptions: ChartOptions = {
    responsive: true,
    legend: {
      position: 'bottom'
    }
  }
  pieChartDataLocal: number[] = [0, 0, 0, 0]
  pieChartLabelsLocal: Label[] = [['ผู้ติดเชื้อ'], ['กำลังรักษา'], ['อาการหนัก'], ['รักษาหาย'], ['เสียชีวิต']]
  pieChartLabels: Label[] = [['ผู้ติดเชื้อ'], ['กำลังรักษา'], ['รักษาหาย'], ['เสียชีวิต']]
  pieChartData: number[] = [0, 0, 0, 0]
  pieChartType: ChartType = 'pie'
  pieChartColorsLocal = [
    {
      backgroundColor: ['#FCD35E', '#BFFD59', '#713ff9', '#5EFCAD', '#FC5E71'],
      borderColor: ['#FCD35E', '#BFFD59', '#713ff9', '#5EFCAD', '#FC5E71']
    }
  ]
  pieChartColors = [
    {
      backgroundColor: ['#FCD35E', '#BFFD59', '#5EFCAD', '#FC5E71']
    }
  ]
  totalLocal: any = {
    confirmed: 0,
    confirmed_add_today: 0,
    healings: 0,
    recovered: 0,
    deaths: 0,
    deaths_add_today: 0,
    watch_out_collectors: 0,
    critical: 0,
    healings_add_today: 0,
    critical_add_today: 0,
    recovered_add_today: 0,
    watch_out_collectors_add_today: 0
  }
  total: any = {
    confirmed: 0,
    confirmed_add_today: 0,
    healings: 0,
    recovered: 0,
    deaths: 0,
    deaths_add_today: 0,
    critical: 0,
    recovered_add_today: 0,
    healings_add_today: 0
  }
  barChartOptions: ChartOptions = {
    responsive: true,
    scales: {
      xAxes: [
        {
          ticks: {
            beginAtZero: true
          }
        }
      ],
      yAxes: [
        {
          ticks: {
            beginAtZero: true
          }
        }
      ]
    }
  }
  barChartDataLocal: any = [
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'ผู้ติดเชื้อ' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'กำลังรักษา' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'อาการหนัก' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'รักษาหายแล้ว' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'เสียชีวิต' }
  ]
  barChartLabels: Label[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
  barChartType: ChartType = 'line'
  barChartData: any = [
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'ผู้ติดเชื้อ' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'กำลังรักษา' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'รักษาหายแล้ว' },
    { data: [0, 0, 0, 0, 0, 0, 0], label: 'เสียชีวิต' }
  ]
  barChartColorsLocal = [
    {
      backgroundColor: 'rgb(252, 211, 94, 0.5)',
      borderColor: '#FCD35E'
    },
    {
      backgroundColor: 'rgb(191, 253, 89, 0.5)',
      borderColor: '#BFFD59'
    },
    {
      backgroundColor: 'rgb(113, 63, 249, 0.5)',
      borderColor: '#713ff9'
    },
    {
      backgroundColor: 'rgb(94, 252, 173, 0.5)',
      borderColor: '#5EFCAD'
    },
    {
      backgroundColor: 'rgb(252, 94, 113, 0.5)',
      borderColor: '#FC5E71'
    }
  ]
  barChartColors = [
    {
      backgroundColor: 'rgb(252, 211, 94, 0.5)',
      borderColor: '#FCD35E'
    },
    {
      backgroundColor: 'rgb(191, 253, 89, 0.5)',
      borderColor: '#BFFD59'
    },
    {
      backgroundColor: 'rgb(94, 252, 173, 0.5)',
      borderColor: '#5EFCAD'
    },
    {
      backgroundColor: 'rgb(252, 94, 113, 0.5)',
      borderColor: '#FC5E71'
    }
  ]
  latitude: number = 13.7530066
  longitude: number = 100.4960144
  hospitals: any = []
  allCountryDisplayedColumns: string[] = [
    'country_flag',
    'country_th',
    'travel',
    'confirmed',
    'healings',
    'recovered',
    'deaths'
  ]
  allCountryDataSource: any = []
  @ViewChild('allCountry', { read: MatSort, static: true })
  allCountrySort: MatSort
  @ViewChild('allCountryPaginator', { static: true })
  allCountryPaginator: MatPaginator

  patientInformationDisplayedColumns: string[] = [
    'statement_date_str',
    'gender',
    'age',
    'job',
    'nationality',
    'province',
    'district',
    'risk'
  ]
  patientInformationDataSource: any = []
  @ViewChild('patientInformation', { read: MatSort, static: true })
  patientInformationSort: MatSort
  @ViewChild('patientInformationPaginator', { static: true })
  patientInformationPaginator: MatPaginator
  patientInformationCount: number = 0

  infectedByProvinceDisplayedColumns: string[] = ['name', 'man_total', 'woman_total', 'no_gender_total', 'infected']
  infectedByProvinceDataSource: any = []
  @ViewChild('infectedByProvince', { read: MatSort, static: true })
  infectedByProvinceSort: MatSort
  @ViewChild('infectedByProvincePaginator', { static: true })
  infectedByProvincePaginator: MatPaginator

  cases: any = []
  safeZones: any = []
  thailandCases: any = []

  genderChartType: string = 'doughnut'
  genderChartDatasets: Array<any> = [{ data: [0, 0, 0] }]
  genderChartLabels: Array<any> = ['ชาย', 'หญิง', 'ไม่ระบุ']
  genderChartColors: Array<any> = [
    {
      backgroundColor: ['rgba(54, 162, 235, 0.2)', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 206, 86, 0.2)'],
      borderColor: ['rgba(54, 162, 235, 1)', 'rgba(255,99,132,1)', 'rgba(255, 206, 86, 1)'],
      borderWidth: 2
    }
  ]
  genderChartOptions: any = {
    responsive: true,
    legend: {
      position: 'bottom'
    }
  }

  ageChartType: string = 'horizontalBar'
  ageChartDatasets: Array<any> = [{ data: Array(10).fill(0) }]
  ageChartLabels: Array<any> = [
    '0-10 ปี',
    '11-20 ปี',
    '21-30 ปี',
    '31-40 ปี',
    '41-50 ปี',
    '51-60 ปี',
    '61-70 ปี',
    '71-80 ปี',
    '81-90 ปี',
    'ไม่ระบุ'
  ]
  ageChartColors: Array<any> = [
    {
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(240, 6, 215, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)',
        'rgba(6, 240, 160, 0.2)',
        'rgba(240, 6, 77, 0.2)',
        'rgba(240, 27, 6, 0.2)',
        'rgba(255, 206, 86, 0.2)'
      ],
      borderColor: [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(240, 6, 215, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)',
        'rgba(6, 240, 160)',
        'rgba(240, 6, 77, 1)',
        'rgba(240, 27, 6, 1)',
        'rgba(255, 206, 86, 1)'
      ],
      borderWidth: 2
    }
  ]
  ageChartOptions: any = {
    responsive: true,
    legend: {
      display: false
    }
  }

  ngOnInit() {
    this.getLocation()
    this.loadCasesThai()
    this.loadHospital()
    this.loadSafeZone()
    this.loadData()

    setInterval(() => {
      if (this.barChartType === 'bar') {
        this.barChartType = 'line'
        this.barChartColorsLocal = [
          {
            backgroundColor: 'rgb(252, 211, 94, 0.5)',
            borderColor: '#FCD35E'
          },
          {
            backgroundColor: 'rgb(191, 253, 89, 0.5)',
            borderColor: '#BFFD59'
          },
          {
            backgroundColor: 'rgb(113, 63, 249, 0.5)',
            borderColor: '#713ff9'
          },
          {
            backgroundColor: 'rgb(94, 252, 173, 0.5)',
            borderColor: '#5EFCAD'
          },
          {
            backgroundColor: 'rgb(252, 94, 113, 0.5)',
            borderColor: '#FC5E71'
          }
        ]
        this.barChartColors = [
          {
            backgroundColor: 'rgb(252, 211, 94, 0.5)',
            borderColor: '#FCD35E'
          },
          {
            backgroundColor: 'rgb(191, 253, 89, 0.5)',
            borderColor: '#BFFD59'
          },
          {
            backgroundColor: 'rgb(94, 252, 173, 0.5)',
            borderColor: '#5EFCAD'
          },
          {
            backgroundColor: 'rgb(252, 94, 113, 0.5)',
            borderColor: '#FC5E71'
          }
        ]
      } else {
        this.barChartType = 'bar'
        this.barChartColorsLocal = [
          {
            backgroundColor: '#FCD35E',
            borderColor: '#FCD35E'
          },
          {
            backgroundColor: '#BFFD59',
            borderColor: '#BFFD59'
          },
          {
            backgroundColor: '#713ff9',
            borderColor: '#713ff9'
          },
          {
            backgroundColor: '#5EFCAD',
            borderColor: '#5EFCAD'
          },
          {
            backgroundColor: '#FC5E71',
            borderColor: '#FC5E71'
          }
        ]
        this.barChartColors = [
          {
            backgroundColor: '#FCD35E',
            borderColor: '#FCD35E'
          },
          {
            backgroundColor: '#BFFD59',
            borderColor: '#BFFD59'
          },
          {
            backgroundColor: '#5EFCAD',
            borderColor: '#5EFCAD'
          },
          {
            backgroundColor: '#FC5E71',
            borderColor: '#FC5E71'
          }
        ]
      }
    }, 30000)
  }

  calculate(isLocal, name, to, from, duration, refreshInterval, step) {
    duration = duration * 1000
    let steps = Math.ceil(duration / refreshInterval)
    let increment = (to - from) / steps
    let num = from
    this.tick(isLocal, name, to, 0, 4, 30, 0, increment, num, steps)
  }

  tick(isLocal, name, to, from, duration, refreshInterval, step, increment, num, steps) {
    let key = 'total'
    if (isLocal) key += 'Local'
    setTimeout(() => {
      num += increment
      step++
      if (step >= steps) {
        num = to
        try {
          this[key][name] = to
        } catch {}
      } else {
        try {
          this[key][name] = Math.round(num)
        } catch {}
        this.tick(isLocal, name, to, from, duration, refreshInterval, step, increment, num, steps)
      }
    }, refreshInterval)
  }

  loadData() {
    this.loadThailandSummary()
    this.thailandRetroact()
    this.globalRetroact()
    this.loadCountryCases()
    this.loadAllCountry()
    this.loadInfectedByProvince()
    this.loadGlobalSummary()
  }

  getLocation() {
    this.app.getPosition().then((pos) => {
      this.latitude = pos.lat
      this.longitude = pos.lng
    })
  }

  loadCasesThai() {
    this.appService.all('api/covids/cases_thai').subscribe(
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
    this.appService.all('api/covids/hospital_and_labs').subscribe(
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
    this.appService.all('api/covids/safe_zone').subscribe(
      (resp) => {
        let response: any = resp
        this.safeZones = response.data
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  loadThailandSummary() {
    this.appService.all('api/covids/thailand_summary').subscribe(
      (resp) => {
        let response: any = resp
        this.localLastUpdated = response.data.last_updated
        this.totalLocal = response.data
        Object.keys(this.totalLocal).forEach((key) => {
          this.calculate(true, key, this.totalLocal[key], 0, 4, 30, 0)
        })
        this.pieChartDataLocal = [
          this.totalLocal.confirmed,
          this.totalLocal.healings,
          this.totalLocal.critical,
          this.totalLocal.recovered,
          this.totalLocal.deaths
        ]
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  thailandRetroact() {
    this.appService.all('api/covids/thailand_retroact').subscribe(
      (resp) => {
        let response: any = resp
        this.barChartLabels = Object.keys(response.data)
        Object.keys(response.data).forEach((key, index) => {
          this.barChartDataLocal[0].data[index] = response.data[key].confirmed
          this.barChartDataLocal[1].data[index] = response.data[key].healings
          this.barChartDataLocal[2].data[index] = response.data[key].critical
          this.barChartDataLocal[3].data[index] = response.data[key].recovered
          this.barChartDataLocal[4].data[index] = response.data[key].deaths
        })
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  globalRetroact() {
    this.appService.all('api/covids/global_retroact').subscribe(
      (resp) => {
        let response: any = resp
        this.barChartLabels = Object.keys(response.data)
        Object.keys(response.data).forEach((key, index) => {
          this.barChartData[0].data[index] = response.data[key].confirmed
          this.barChartData[1].data[index] = response.data[key].healings
          this.barChartData[2].data[index] = response.data[key].recovered
          this.barChartData[3].data[index] = response.data[key].deaths
        })
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  loadGlobalSummary() {
    this.appService.all('api/covids/global_summary').subscribe(
      (resp) => {
        let response: any = resp
        this.globleLastUpdated = response.data.last_updated
        this.total = response.data
        Object.keys(this.total).forEach((key) => {
          this.calculate(false, key, this.total[key], 0, 4, 30, 0)
        })
        this.pieChartData = [this.total.confirmed, this.total.healings, this.total.recovered, this.total.deaths]
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  loadAllCountry() {
    this.appService.all('api/covids/world').subscribe(
      (resp) => {
        let response: any = resp
        this.allCountryDataSource = new MatTableDataSource<any>(response.data)
        this.allCountryDataSource.paginator = this.allCountryPaginator
        this.allCountryDataSource.sort = this.allCountrySort
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  loadCountryCases() {
    this.appService.all('api/covids/thailand_cases').subscribe(
      (resp) => {
        let response: any = resp
        this.thailandCases = response.data
        this.patientInformationCount = this.thailandCases.length
        this.patientInformationDataSource = new MatTableDataSource<any>(this.thailandCases)
        this.patientInformationDataSource.paginator = this.patientInformationPaginator
        this.patientInformationDataSource.sort = this.patientInformationSort
        this.calculateGenderChart()
        this.calculateAgeChart()
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  calculateGenderChart() {
    let man = this.thailandCases.filter((c) => c.gender === 'ชาย').length || 0
    let woman = this.thailandCases.filter((c) => c.gender === 'หญิง').length || 0
    let noGender = this.thailandCases.filter((c) => c.gender === '-').length || 0
    this.genderChartDatasets = [{ data: [man, woman, noGender] }]
  }

  calculateAgeChart() {
    let data = Array(10).fill(0)
    this.thailandCases.forEach((c) => {
      if (c.age >= 0 && c.age <= 10) {
        data[0] += 1
      } else if (c.age >= 11 && c.age <= 20) {
        data[1] += 1
      } else if (c.age >= 21 && c.age <= 30) {
        data[2] += 1
      } else if (c.age >= 31 && c.age <= 40) {
        data[3] += 1
      } else if (c.age >= 41 && c.age <= 50) {
        data[4] += 1
      } else if (c.age >= 51 && c.age <= 60) {
        data[5] += 1
      } else if (c.age >= 61 && c.age <= 70) {
        data[6] += 1
      } else if (c.age >= 71 && c.age <= 80) {
        data[7] += 1
      } else if (c.age >= 81 && c.age <= 90) {
        data[8] += 1
      } else {
        data[9] += 1
      }
    })

    this.ageChartDatasets[0].data = data
  }

  searchPatientInformation(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value
    this.patientInformationDataSource.filter = filterValue.trim().toLowerCase()

    if (this.patientInformationDataSource.paginator) {
      this.patientInformationDataSource.paginator.firstPage()
    }
  }

  searchAllCountry(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value
    this.allCountryDataSource.filter = filterValue.trim().toLowerCase()

    if (this.allCountryDataSource.paginator) {
      this.allCountryDataSource.paginator.firstPage()
    }
  }

  loadInfectedByProvince() {
    this.appService.all('api/covids/thailand_infected_province').subscribe(
      (resp) => {
        let response: any = resp
        this.infectedByProvinceDataSource = new MatTableDataSource<any>(response.data)
        this.infectedByProvinceDataSource.paginator = this.infectedByProvincePaginator
        this.infectedByProvinceDataSource.sort = this.infectedByProvinceSort
      },
      (e) => {
        this.app.openSnackBar('มีข้อผิดพลาด ในการโหลดข้อมูล', 'Close', 'red-snackbar')
      }
    )
  }

  searchInfectedByProvince(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value
    this.infectedByProvinceDataSource.filter = filterValue.trim().toLowerCase()

    if (this.infectedByProvinceDataSource.paginator) {
      this.infectedByProvinceDataSource.paginator.firstPage()
    }
  }

  animateValue(value, start, end, duration) {
    let range = end - start
    let current = start
    let increment = end > start ? 1 : -1
    let stepTime = Math.abs(Math.floor(duration / range))
    let timer = setInterval(function() {
      value += increment
      if (value == end) {
        clearInterval(timer)
      }
    }, stepTime)
  }
}
