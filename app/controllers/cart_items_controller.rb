class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @cart_item = current_cart.cart_items.build(product: product, quantity: 1)
    @cart_item.save
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:quantity])
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy

    redirect_to cart_path(current_cart), notice: 'Item removed from the cart.'
  end

end
