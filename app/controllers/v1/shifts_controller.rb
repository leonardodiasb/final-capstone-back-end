class V1::ShiftsController < ApplicationController
  def index
    @shifts = Shift.json_list
    render json: @shifts
  end
end
