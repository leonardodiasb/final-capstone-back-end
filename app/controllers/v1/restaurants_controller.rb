class V1::RestaurantsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @restaurants = Restaurant.json_list
    render json: @restaurants
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: { status: 'SUCCESS', message: 'You created a restaurant!', data: @restaurant },
             status: :created
    else
      render json: { status: 'ERROR', message: 'Failed to create a restaurant', error: @restaurant.errors },
             status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.permit(
      :name,
      :image,
      :description,
      :reservation_spots,
      :price_range
    )
  end
end
