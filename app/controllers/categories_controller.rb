class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(10)
  end
  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category.id).page(params[:page]).per(10)
  end
end
