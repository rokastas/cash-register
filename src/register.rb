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

  def display_cart
    puts "--------------- Your Cart ---------------"
    if @cart.empty?
      puts "Your cart is empty."
    else
      @cart.each do |product, quantity|
        puts "#{product.name} (#{quantity}x) - ??? €"
      end
    end
    puts "-----------------------------------------"
    puts "Total: ??? €"
    puts ""
  end
end
