require 'json'
require_relative 'product'

class Register
  def initialize
    # Loads products from the JSON file
    Product.load_products('data/products.json')
    @cart = {}
  end

  def products
    @products = Product.all
  end

  def cart
    @cart
  end

  def add_to_cart(product, quantity)
    # Initialize cart entry for the product if it doesn't exist
    @cart[product] ||= 0

    # Increment the quantity of the product in the cart
    @cart[product] += quantity
  end

  def total_price_per_product(product_price, product_quantity)
    product_price * product_quantity
  end

  def discounted_price_per_product(product_code, product_price, product_quantity)
    pricing_rules_file = File.read('data/pricing_rules.json')
    pricing_rules = JSON.parse(pricing_rules_file)

    rule = pricing_rules.find { |rule| rule['product_code'] == product_code }

    if rule && rule['type'] == 'BOGO'
      return product_quantity.even? ? (product_quantity / 2) * product_price : ((product_quantity - 1) / 2) * product_price + product_price
    elsif rule && rule['type'] == 'BulkDiscount' && product_quantity >= rule['threshold']
      if rule['discount_price']
        return product_quantity * rule['discount_price']
      elsif rule['discount_percent']
        return product_quantity * product_price * (1 - rule['discount_percent'])
      end
    end

    product_price * product_quantity
  end

  def total_cart_price
    total_cart_price = 0
    @cart.each do |product, product_quantity|
      total_cart_price += discounted_price_per_product(product.code, product.price, product_quantity).to_f
    end
    total_cart_price
  end
end
