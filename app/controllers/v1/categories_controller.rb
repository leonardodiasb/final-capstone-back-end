class V1::CategoriesController < ApplicationController
  def index
    @categories = Category.json_list
    render json: @categories
  end

  def create
    if @current_user.role == 'admin'
      @category = Category.new(name: params[:name])
      return render json: @category.errors, status: :unprocessable_entity unless @category.save

      render json: { status: :created, message: 'Category created successfully.', body: @category }, status: :created
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  def destroy
    if @current_user.role == 'admin'
      @category = Category.find(params[:id])
      return render json: @category.errors, status: :unprocessable_entity unless @category.destroy

      render json: { status: :no_content, message: 'Category deleted successfully.', body: nil }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
end
