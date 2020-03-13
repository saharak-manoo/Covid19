class CovidsController < ApplicationController
  def index
    render json: { data: Covid.daily_reports }, status: :ok
  end

  def total
    render json: { data: Covid.total }, status: :ok
  end

  def country
    render json: { data: Covid.country(params[:nation] || 'TH') }, status: :ok
  end

  def retroact
    render json: { data: Covid.retroact }, status: :ok
  end

  def total_retroact
    render json: { data: Covid.total_retroact }, status: :ok
  end
end