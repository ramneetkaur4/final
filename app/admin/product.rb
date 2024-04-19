# app/admin/product.rb

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id

  filter :name
  filter :description
  filter :price

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    actions
  end

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image, as: :file, label: 'Product Image'
    end
    f.actions
  end

end
