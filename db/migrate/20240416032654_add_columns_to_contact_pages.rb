class AddColumnsToContactPages < ActiveRecord::Migration[7.0]
  def change
    add_column :contact_pages, :title, :string
    add_column :contact_pages, :content, :string
  end
end
