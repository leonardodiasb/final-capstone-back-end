class V1::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(page)
    pagination_headers(@restaurants)
    render json: @restaurants.json_list
  end

  def create
    @current_user = AuthorizeApiRequest.call(request.headers).result
    if @current_user.role == 'admin'
      @restaurant = Restaurant.new(restaurant_params)

      restaurant_shift_params.each do |shift|
        @restaurant.shifts << Shift.find(shift)
      end

      restaurant_category_params.each do |category|
        @restaurant.categories << Category.find(category)
      end

      if @restaurant.save
        render json: { status: 'SUCCESS', message: 'You created a restaurant!', data: @restaurant },
               status: :created
      else
        render json: { status: 'ERROR', message: 'Failed to create a restaurant', error: @restaurant.errors },
               status: :bad_request
      end
    else
      render json: { status: 'ERROR', message: 'Only admins can create a restaurant' },
             status: :unauthorized
    end
  end

  def destroy
    @current_user = AuthorizeApiRequest.call(request.headers).result
    return unless @current_user.role == 'admin'

    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    render json: { status: 'SUCCESS', message: 'Restaurant Deleted', data: @restaurant }, status: :ok
  end

  def availability
    @restaurant = Restaurant.find(params[:restaurant_id])
    render json: { status: 'SUCCESS', body: @restaurant.spots(params[:date]) }, status: :ok
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :image,
      :description,
      :reservation_spots,
      :price_range
    )
  end

  def restaurant_shift_params
    params.require(:shifts)
  end

  def restaurant_category_params
    params.require(:categories)
  end
end
