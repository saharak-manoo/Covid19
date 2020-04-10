class Api::CovidsController < Api::ApplicationController
  respond_to :json

  def index
    render json: { data: Covid.daily_reports }, status: :ok
  end

  def total
    render json: { data: Covid.total }, status: :ok
  end

  def retroact
    render json: { data: Covid.retroact }, status: :ok
  end

  def country
    render json: { data: Covid.country(params[:nation] || 'TH') }, status: :ok
  end

  def country_retroact
    render json: { data: Covid.country_retroact(params[:nation] || 'TH') }, status: :ok
  end

  def constants
    render json: { data: Covid.constants }, status: :ok
  end

  def world
    render json: { data: World.all.as_json({ api: true }) }, status: :ok
  end

  def cases
    render json: { data: Covid.cases }, status: :ok
  end

  def trends
    render json: { data: Covid.trends }, status: :ok
  end

  def summary_of_past_data
    render json: { data: Covid.summary_of_past_data }, status: :ok
  end

  def cases_thai
    render json: { data: Covid.cases_thai }, status: :ok
  end

  def hospital
    render json: { data: Covid.hospitals }, status: :ok
  end

  def safe_zone
    render json: { data: Covid.safe_zone }, status: :ok
  end

  def infected_by_province
    render json: { data: Covid.thai_summary }, status: :ok
  end

  def hospital_and_labs
    render json: { data: Covid.hospital_and_labs }, status: :ok
  end

  def thai_ddc
    render json: { data: Covid.thai_ddc }, status: :ok
  end

  def thai_separate_province
    render json: { data: Covid.thai_separate_province }, status: :ok
  end

  def global_confirmed
    render json: { data: Covid.global_confirmed }, status: :ok
  end

  def global_confirmed_add_today
    render json: { data: Covid.global_confirmed_add_today }, status: :ok
  end

  def global_recovered
    render json: { data: Covid.global_recovered }, status: :ok
  end

  def global_critical
    render json: { data: Covid.global_critical }, status: :ok
  end

  def global_deaths
    render json: { data: Covid.global_deaths }, status: :ok
  end

  def global_deaths_add_today
    render json: { data: Covid.global_deaths_add_today }, status: :ok
  end

  def thailand_summary
    render json: { data: ThailandSummary.find_by(date: Date.today).as_json({api: true}) || ThailandSummary.find_by(date: Date.yesterday).as_json({api: true}) }, status: :ok
  end  

  def global_summary
    render json: { data: GlobalSummary.find_by(date: Date.today).as_json({api: true}) || GlobalSummary.find_by(date: Date.yesterday).as_json({api: true}) }, status: :ok
  end

  def thailand_retroact
    days = params[:days] || 6
    data = {}
    ThailandSummary.where(date: Date.today - days..Date.today).order(date: :asc).each do |thailand_summary|
      data[thailand_summary.date.strftime("%a")] = thailand_summary.as_json({api: true})
    end

    render json: { data: data }, status: :ok
  end

  def global_retroact
    days = params[:days] || 6
    data = {}
    GlobalSummary.where(date: Date.today - days..Date.today).order(date: :asc).each do |global_summary|
      data[global_summary.date.strftime("%a")] = global_summary.as_json({api: true})
    end

    render json: { data: data }, status: :ok
  end

  def thailand_cases
    render json: { data: Covid.v2_cases }, status: :ok
  end

  def thailand_infected_province
    Covid.thailand_infected_province
    
    render json: { data: InfectedProvince.where(date: Date.today).as_json({api: true}) }, status: :ok
  end

  def hospital_by_location
    render json: { data: Hospital.all.as_json({api: true, lat: params[:latitude], long: params[:longitude]}) }, status: :ok
  end

  def thailand_case_by_location
    render json: { data: ThailandCase.all.as_json({api: true, lat: params[:latitude], long: params[:longitude]}) }, status: :ok
  end

  def thailand_today
    render json: { data: Covid.thailand_today }, status: :ok
  end

  def thailand_timeline
    render json: { data: Covid.thailand_timeline }, status: :ok
  end

  def thailand_area
    render json: { data: Covid.thailand_area }, status: :ok
  end

  def thailand_timeline_for_chart
    timeline = Covid.thailand_timeline

    render json: { data: 
      {
        start_date: timeline.first[:date_thai_str],
        end_date: timeline.last[:date_thai_str],
        categories: timeline.pluck(:date),
        series: [
          {
            name: 'ผู้ติดเชื้อ',
            data: timeline.pluck(:confirmed),
          },
          {
            name: 'ผู้ติดเชื้อเพิ่มขึ้น',
            data: timeline.pluck(:confirmed_add_today),
          },
          {
            name: 'กำลังรักษา',
            data: timeline.pluck(:healings),
          },
          {
            name: 'กำลังรักษาเพิ่มขึ้น',
            data: timeline.pluck(:healings_add_today),
          },
          {
            name: 'รักษาหาย',
            data: timeline.pluck(:recovered),
          },
          {
            name: 'รักษาหายเพิ่มขึ้น',
            data: timeline.pluck(:recovered_add_today),
          },
          {
            name: 'เสียชีวิต',
            data: timeline.pluck(:deaths),
          },
          {
            name: 'เสียชีวิตเพิ่มขึ้น',
            data: timeline.pluck(:deaths_add_today),
          },
        ]
      } 
    }, status: :ok
  end
end