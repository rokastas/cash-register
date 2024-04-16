require_relative 'product'

class Register
  def initialize
    # Loads products from the JSON file
    Product.load_products('data/products.json')
  end

  def products
    @products = Product.all
  end
end
