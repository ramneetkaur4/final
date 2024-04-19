require 'faker'
require 'csv'

def import_products_from_csv(filepath)
  # Check if file exists
  unless File.exist?(filepath)
    puts "Error: File not found - #{filepath}"
    return
  end

  # Open the CSV file
  # CSV.foreach(filepath, headers: true) do |row|
    # Extract product data from each row
    name = row["Name"]
    description = row["Description"]
    price = row["Price"].to_f  # Convert price string to float
    category_name = row["Category"]

    # Find the category or create a new one if it doesn't exist
    category = Category.find_by(name: category_name) || Category.create(name: category_name)

    # Create a new product with extracted data
    Product.create(name: name, description: description, price: price, category: category)
  end

  puts "Successfully imported products from #{filepath}"
end

# Create categories if they don't already exist
categories = Category.all

if categories.empty?
  categories = ['Winter Jackets', 'Fashion Jackets', 'Leather Jackets', 'Sports Jackets'].map do |name|
    Category.create(name: name)
  end
end

# Generate fake products with random category assignments
100.times do |i|  # Adjust the number of products (e.g., 100)
  # Randomly pick a category
  category = categories.sample

  # Generate random product attributes
  Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 100.0..500.0),
    category: category
  )
end

import_products_from_csv('db/products.csv')

puts "Created #{Product.count} products across #{Category.count} categories"
