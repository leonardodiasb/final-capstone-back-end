class V1::CategoriesController < ApplicationController
  def index
    @categories = Category.json_list
    render json: @categories
  end
end
