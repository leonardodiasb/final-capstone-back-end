class V1::RestaurantsController < ApiController
  def index
    message = 'hello world'
    render json: message
  end
end
