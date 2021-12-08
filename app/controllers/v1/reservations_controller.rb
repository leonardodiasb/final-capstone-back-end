class V1::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: @current_user.id)
    render json: @reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = @current_user.id
    return render json: @reservation.errors, status: :unprocessable_entity unless @reservation.save

    render json: { status: :created, message: 'Reservation created successfully.', body: @reservation }, status: :ok
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    return render json: @reservation.errors, status: :unprocessable_entity unless @reservation.destroy

    render json: { status: :no_content, message: 'Reservation deleted successfully.', body: nil }, status: :ok
  end

  private

  def reservation_params
    params.permit(
      :date,
      :shift,
      :restaurant_id
    )
  end
end