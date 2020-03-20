class CovidsController < ApplicationController
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

  def hospital
    render json: { data: Hospital.all.as_json({api: true}) }, status: :ok
  end

  def constants
    render json: { data: Covid.constants }, status: :ok
  end

  def world
    render json: { data: Covid.world }, status: :ok
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
end