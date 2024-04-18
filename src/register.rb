# This class is responsible for managing the cart and calculating the total price of the cart.
# It provides methods to add and remove products from the cart, calculate the total price of the cart,
# and apply any discount rules that may be defined for the products.
# The Register class is used by the App class and uses the Product class.

require 'json'
require_relative 'product'

class Register
  attr_reader :cart, :products

  def initialize
    @products = Product.load_products('data/products.json')
    @pricing_rules = load_pricing_rules
    @cart = {} # Hash with Product objects as keys and their quantities as values.
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

    if rule
      if rule['type'] == 'BOGO'
        return calculate_bogo_discount(product_price, product_quantity)
      elsif rule['type'] == 'BulkDiscount' && product_quantity >= rule['threshold']
        return calculate_bulk_discount(product_price, product_quantity, rule)
      else
        puts 'This discount rule has not been implemented yet.' \
             'Returning the original price.'
        return product_price * product_quantity
      end
    end

    # If there is no discount rule for the product
    product_price * product_quantity
  end

  def total_cart_price
    @cart.sum { |product, quantity| discounted_price_per_product(
      product.code, product.price, quantity
    ).to_f}
  end

  private

  def load_pricing_rules
    JSON.parse(File.read('data/pricing_rules.json'))
  rescue Errno::ENOENT, JSON::ParserError => e
    puts "Error loading pricing rules: #{e.message}"
    []
  end

  def calculate_bogo_discount(product_price, product_quantity)
    if product_quantity.even?
      discount_amount = (product_quantity / 2) * product_price
    else
      discount_amount = ((product_quantity - 1) / 2) * product_price + product_price
    end
    discount_amount
  end

  def calculate_bulk_discount(product_price, product_quantity, rule)
    if rule['discount_price']
      product_quantity * rule['discount_price']
    elsif rule['discount_percent']
      product_quantity * product_price * (1 - rule['discount_percent'])
    else
      puts 'This bulk discount rule has not been implemented yet.' \
           'Returning the original price.'
      product_price * product_quantity
    end
  end
end
