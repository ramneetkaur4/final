# app/controllers/search_controller.rb

class SearchController < ApplicationController
  def index
    @categories = Category.all

    if params[:keyword].present?
      @products = Product.where("name LIKE ?", "%#{params[:keyword]}%")
    else
      @products = Product.joins(:category)
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
  end
end
