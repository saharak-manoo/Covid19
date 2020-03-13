class CovidsController < ApplicationController
  def index
    render json: { data: Covid.current, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def confirmed
    render json: { data: Covid.confirmed, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def total
    render json: { data: Covid.total, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def total_confirmed
    render json: { data: Covid.total_confirmed, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def deaths
    render json: { data: Covid.deaths, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def recovered
    render json: { data: Covid.recovered, api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def country
    render json: { data: Covid.country(params[:nation]), api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def timeseries_confirmed
    render json: { data: Covid.country(params[:timeseries_confirmed]), api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def timeseries_deaths
    render json: { data: Covid.country(params[:timeseries_deaths]), api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end

  def timeseries_recovered
    render json: { data: Covid.country(params[:timeseries_recovered]), api_from: "https://github.com/nat236919/Covid2019API" }, status: :ok
  end
end