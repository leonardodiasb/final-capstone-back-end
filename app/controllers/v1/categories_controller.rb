class V1::CategoriesController < ApplicationController
  def index
    @categories = Category.json_list
    render json: @categories
  end

  def create
    @category = Category.new(name: params[:name])
    return render json: @category.errors, status: :unprocessable_entity unless @category.save

    render json: { status: :created, data: @category }
  end
end
