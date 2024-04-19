class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items)
  end

  def show
    @user = current_user
    @orders = @user.orders.all
  end

  def create
    @order_item = OrderItem.where("product_id = ? AND order_id = ?", params[:order_item][:product_id], session[:order_id]).first
    if @order_item
      @order_item.update(quantity: @order_item.quantity + params[:order_item][:quantity].to_i)
      @order_item.save
    else
      @order = current_order
      @order.user = current_user.present? ? current_user : User.last
      @order.order_items.new(order_item_params)
      @order.save
      session[:order_id] = @order.id
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find_by(id: params[:id])

    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to cart_path, notice: 'Order item quantity was successfully updated.' }
        format.json { render json: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find_by(id: params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_path
  end

  def checkout
    if !current_user
      redirect_to new_user_session_path
    elsif params["payment_method"] == "0"
      current_order.update(address: params["address"], payment_method: params["payment_method"].to_i, user_id: current_user.id)
      redirect_to order_successful_path
    else
      redirect_to new_payment_path
    end
  end

  def order_successful
    @order = current_order
    session[:order_id] = nil
  end
  def show
    @order = Order.find(params[:id])
    @order.calculate_taxes
  end
  def index
    @orders = Order.all
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :amount)
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
