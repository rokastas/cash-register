# This class represents a user interface for interacting with the checkout system.

class UserInterface
  INVALID_INDEX_MESSAGE = 'Invalid product index. Please enter a whole number no bigger than %d.'.freeze
  INVALID_QUANTITY_MESSAGE = 'Invalid quantity. Please enter a whole number greater than 0.'.freeze

  def display_welcome_message
    puts '---------------------------------------------------------------'
    puts '---------------- Welcome to the Checkout System ---------------'
    puts '---------------------------------------------------------------'
    puts ''
  end

  def ask_for_action
    puts 'Please select an action:'
    puts '1. Add products to cart'
    puts '2. Remove products from cart'
    puts '3. Checkout and exit'
    print '> '
    gets.chomp
  end

  def display_products(products)
    puts ''
    puts 'Select a product:'
    products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name} - #{format('%.2f', product.price)} €"
    end
  end

  def ask_for_product_index(products_length)
    puts 'Enter the number of the product: '
    print '> '
    product_index_input = gets.chomp

    if product_index_input.match(/^\d+$/)
      product_index = product_index_input.to_i
      return product_index - 1 if product_index >= 1 && product_index <= products_length
    end

    puts INVALID_INDEX_MESSAGE % products_length
    puts ''
    ask_for_product_index(products_length)
  end

  def ask_for_product_quantity(product_to_remove = nil, product_quantity_in_cart = nil)
    puts product_quantity_prompt_message(product_to_remove, product_quantity_in_cart)
    print '> '
    product_quantity_input = gets.chomp

    if product_quantity_input.match(/^\d+$/) &&
       (product_quantity = product_quantity_input.to_i).positive? &&
       (!product_to_remove || product_quantity <= product_quantity_in_cart)
      return product_quantity
    end

    display_invalid_product_quantity_message(product_to_remove, product_quantity_in_cart)
  end

  def display_cart(register)
    cart = register.cart
    total_cart_price = register.total_cart_price

    puts ''
    puts '-------------------------- Your Cart --------------------------'
    display_cart_products(cart, register)
    puts '---------------------------------------------------------------'
    puts "Total: #{format('%.2f', total_cart_price)} €"
    puts ''
  end

  def display_invalid_action_message
    puts 'Invalid action. Please enter a valid action number.'
    puts ''
  end

  private

  def display_cart_products(cart, register)
    if cart.empty?
      puts 'Your cart is empty.'
    else
      cart.each_with_index do |(product, product_quantity), index|
        puts "#{index + 1}. #{product.name} (#{product_quantity}x) - " \
        "#{price_per_product_message(register, product, product_quantity)}"
      end
    end
  end

  def price_per_product_message(register, product, product_quantity)
    discounted_price_per_product = register.discounted_price_per_product(product.code, product.price, product_quantity)
    total_price_per_product = register.total_price_per_product(product.price, product_quantity)

    message = "#{format('%.2f', discounted_price_per_product)} €"

    if discounted_price_per_product != total_price_per_product
      message += ", discounted from: #{format('%.2f', total_price_per_product)} €"
    end

    message
  end

  def product_quantity_prompt_message(product_to_remove = nil, product_quantity_in_cart = nil)
    if product_to_remove
      "Enter the quantity of #{product_to_remove.name} to remove " \
      "(you have #{product_quantity_in_cart} in your cart):"
    else
      'Enter the quantity of the product:'
    end
  end

  def display_invalid_product_quantity_message(product_to_remove, product_quantity_in_cart)
    puts "Invalid quantity. Please enter a whole number " \
    "#{product_to_remove ? 'no bigger than' : 'greater than'}" \
    " #{product_to_remove ? product_quantity_in_cart : 0}."
    puts ''
    ask_for_product_quantity(product_to_remove, product_quantity_in_cart)
  end
end
