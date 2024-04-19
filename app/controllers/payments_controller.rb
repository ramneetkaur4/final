class PaymentsController < ApplicationController
  def new; end

  def create
    @order = current_order
    @amount = current_order.total_amount

    if @amount.to_i <= 0
      flash[:error] = "Order total cannot be less than or equal to $0. Please add items to your order."
      redirect_to new_payment_path
      return
    end

    customer = Stripe::Customer.create email: params[:"cardholder-email"],
                                       :source => params[:stripeToken]
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount.to_i,
      :description => 'Heebie Jeebies',
      :currency => 'cad'
    )

    session[:order_id] = nil
    current_order.update(user_id: current_user.id)

  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to new_payment_path
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
