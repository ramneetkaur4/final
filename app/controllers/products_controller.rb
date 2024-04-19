class ProductsController < ApplicationController
  def index
    case params[:filter]
    when "on_sale"
      @products = Product.where("price < ?", 100).page(params[:page]).per(10)
      @on_sale_products = @products
    when "new"
      @new_products = Product.where("created_at >= ?", 3.days.ago).order(created_at: :desc).page(params[:page]).per(10)
      @products = @new_products
    when "recently_updated"
      @new_products = Product.where("created_at >= ?", 3.days.ago).order(created_at: :desc).page(params[:page]).per(10)
      @recently_updated_products = Product.where("updated_at >= ?", 3.days.ago).page(params[:page]).per(10)
                                         .where.not(id: @new_products.pluck(:id))
      @products = @recently_updated_products
    else
    @products = Product.joins(:category).distinct.order(created_at: :desc).page(params[:page]).per(10)
    end

    @on_sale_products ||= Product.where("price < ?", 100).page(params[:page]).per(10)
  end


  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end


  private

  def calculate_sale_price(original_price)
    sale_percentage = 10
    sale_price = original_price - (original_price * sale_percentage / 100)
    sale_price
  end

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      begin
        Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound => exception
        Order.new
      end
    end
  end
end
