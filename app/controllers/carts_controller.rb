class CartsController < ApplicationController
  # Display the current cart
  def show
    @order = current_order
    @cart_items = current_order&.order_items
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

  # Add a product to the cart
  # def add_to_cart
  #   product_id = params[:product_id].to_i
  #   quantity = params[:quantity].to_i
  #
  #   cart = session[:cart] || {}
  #   cart[product_id] = (cart[product_id] || 0) + quantity
  #   session[:cart] = cart
  #   p session[:cart]
  #   if cart[product_id] > 0
  #     flash[:notice] = "#{quantity} #{'item'.pluralize(quantity)} added to cart."
  #   end
  #   redirect_to product_path(params[:product_id]), notice: "Product added to cart."
  # end
  #
  # # Update the quantity of a product in the cart
  # def update_quantity
  #   product_id = params[:product_id].to_i
  #   quantity = params[:quantity].to_i
  #
  #   @cart = session[:cart] || {}
  #
  #   if @cart.key?(product_id)
  #     if quantity > 0
  #       @cart[product_id] = quantity
  #     else
  #       @cart.delete(product_id)
  #     end
  #
  #     session[:cart] = @cart
  #     flash[:notice] = "Quantity updated successfully."
  #   else
  #     flash[:alert] = "Item not found in cart. Cart remains unchanged."
  #   end
  #
  #   redirect_to cart_path
  # end
  #
  # # Increase the quantity of a product in the cart by 1
  # def increase_quantity
  #   product_id = params[:product_id].to_i
  #   @cart[product_id] = (@cart[product_id] || 0) + 1
  #   session[:cart] = @cart
  #
  #   redirect_to cart_path
  # end
  #
  # # Decrease the quantity of a product in the cart by 1
  # def decrease_quantity
  #   product_id = params[:product_id].to_i
  #   @cart[product_id] = [@cart[product_id] - 1, 0].max
  #   session[:cart] = @cart
  #
  #   redirect_to cart_path
  # end
  #
  # # Remove a product from the cart
  # def remove_from_cart
  #   product_id = params[:product_id].to_i
  #
  #   @cart = session[:cart] || {}
  #
  #   if @cart.key?(product_id)
  #     @cart.delete(product_id)
  #     session[:cart] = @cart
  #     flash[:notice] = "Item removed from cart successfully."
  #   else
  #     flash[:alert] = "Item not found in cart. Cart remains unchanged."
  #   end
  #
  #   redirect_to cart_path
  # end

end
