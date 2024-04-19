class DropCartItemsCartsAndCartsProducts < ActiveRecord::Migration[7.0]
  def change
    drop_table :cart_items if table_exists?(:cart_items)
    drop_table :carts_products if table_exists?(:carts_products)
    drop_table :carts if table_exists?(:carts)
  end
end
