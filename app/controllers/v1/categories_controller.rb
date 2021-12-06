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

  def destroy
    @category = Category.find(params[:id])
    return render json: @category.errors, status: :unprocessable_entity unless @category.destroy

    render json: { status: :no_content, message: 'Category deleted successfully.', body: nil }, status: :ok
  end
end
