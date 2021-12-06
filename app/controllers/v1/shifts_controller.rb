class V1::ShiftsController < ApplicationController
  def index
    @shifts = Shift.json_list
    render json: @shifts
  end

  def create
    if @current_user.role == 'admin'
      @shift = Shift.new(name: params[:name])
      return render json: @shift.errors, status: :unprocessable_entity unless @shift.save

      render json: { status: :created, message: 'Shift created successfully.', body: @shift }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  def destroy
    if @current_user.role == 'admin'
      @shift = Shift.find(params[:id])
      return render json: @shift.errors, status: :unprocessable_entity unless @shift.destroy

      render json: { status: :no_content, message: 'Shift deleted successfully.', body: nil }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
end
