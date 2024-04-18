# This class represents a product in the checkout system.
# It provides a method to load products from a JSON file.
# The Product class is used by the Register class.

require 'json'

class Product
  attr_reader :code, :name, :price

  @products = []
  def self.all
    @products
  end

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  def self.load_products(file_path)
    products_data = File.read(file_path)
    products_hash = JSON.parse(products_data)

    @products = products_hash.map do |product_data|
      new(product_data['code'], product_data['name'], product_data['price'])
    end

    all
  rescue Errno::ENOENT, JSON::ParserError => e
    puts "Error loading products: #{e.message}"
    []
  end
end
