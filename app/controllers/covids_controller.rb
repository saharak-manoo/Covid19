class CovidsController < ApplicationController
  def index
    ap '>>>>>>>> current'
    data = Covid.current
    ap data
     ap '>>>>>>>> confirmed'
    ap Covid.confirmed

    render json: { data: data }, status: :ok
  end
end