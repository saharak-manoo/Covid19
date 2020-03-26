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
end