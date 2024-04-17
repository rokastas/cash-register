class UserInterface
  def display_welcome_message
    puts '-------------------------------------------------------'
    puts '------------ Welcome to the Checkout System -----------'
    puts '-------------------------------------------------------'
    puts ''
  end

  def ask_for_action
    puts 'Please select an action:'
    puts '1. Add products to cart'
    puts '2. Checkout and exit'
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
    puts 'Enter the number of the product you want to add: '
    print '> '
    product_index_input = gets.chomp

    if product_index_input.match(/^\d+$/)
      product_index = product_index_input.to_i
      return product_index - 1 if product_index >= 1 && product_index <= products_length
    end

    puts "Invalid product index. Please enter a whole number between 1 and #{products_length}."
    puts ''
    ask_for_product_index(products_length)
  end

  def ask_for_product_quantity
    puts 'Enter the quantity of the product: '
    print '> '
    product_quantity_input = gets.chomp

    if product_quantity_input.match(/^\d+$/)
      product_quantity = product_quantity_input.to_i
      return product_quantity if product_quantity.positive?
    end

    puts 'Invalid quantity. Please enter a whole number greater than 0.'
    puts ''
    ask_for_product_quantity
  end

  def display_cart(register)
    cart = register.cart
    total_cart_price = register.total_cart_price

    puts ''
    puts '---------------------- Your Cart ----------------------'
    if cart.empty?
      puts 'Your cart is empty.'
    else
      cart.each do |product, product_quantity|
        puts "#{product.name} (#{product_quantity}x) - #{price_per_product_message(register, product, product_quantity)}"
      end
    end
    puts '-------------------------------------------------------'
    puts "Total: #{format('%.2f', total_cart_price)} €"
    puts ''
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
end
