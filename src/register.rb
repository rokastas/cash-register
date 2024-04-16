class Register
  def initialize
    # Loads products from the JSON file
    Product.load_products('data/products.json')
    @products = Product.all
  end
end
