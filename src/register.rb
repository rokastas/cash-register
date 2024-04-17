require 'json'
require_relative 'product'

class Register
  attr_reader :cart, :products

  def initialize
    @products = load_products
    @cart = {}
    @pricing_rules = load_pricing_rules
  end

  def add_to_cart(product, quantity)
    @cart[product] ||= 0
    @cart[product] += quantity
  end

  def remove_from_cart(product, quantity)
    @cart[product] -= quantity
    @cart.delete(product) if @cart[product].zero?
  end

  def total_price_per_product(product_price, product_quantity)
    product_price * product_quantity
  end

  def discounted_price_per_product(product_code, product_price, product_quantity)
    rule = @pricing_rules.find { |rule| rule['product_code'] == product_code }

    if rule && rule['type'] == 'BOGO'
      return calculate_bogo_discount(product_price, product_quantity)
    elsif rule && rule['type'] == 'BulkDiscount' && product_quantity >= rule['threshold']
      return calculate_bulk_discount(product_price, product_quantity, rule)
    end

    product_price * product_quantity
  end

  def total_cart_price
    @cart.sum { |product, quantity| discounted_price_per_product(product.code, product.price, quantity).to_f }
  end

  private

  def load_products
    Product.load_products('data/products.json')
    Product.all
  end

  def load_pricing_rules
    JSON.parse(File.read('data/pricing_rules.json'))
  rescue Errno::ENOENT, JSON::ParserError => e
    puts "Error loading pricing rules: #{e.message}"
    []
  end

  def calculate_bogo_discount(product_price, product_quantity)
    product_quantity.even? ? (product_quantity / 2) * product_price : ((product_quantity - 1) / 2) * product_price + product_price
  end

  def calculate_bulk_discount(product_price, product_quantity, rule)
    if rule['discount_price']
      product_quantity * rule['discount_price']
    elsif rule['discount_percent']
      product_quantity * product_price * (1 - rule['discount_percent'])
    end
  end
end
