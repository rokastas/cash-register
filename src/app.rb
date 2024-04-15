require_relative 'product'

class App
  Product.load_products('data/products.json')
end
