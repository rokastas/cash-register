class User_interface
  def display_welcome_message
    puts "-------------------------------------------"
    puts "----- Welcome to the Checkout System -----"
    puts "-------------------------------------------"
    puts ""
  end

  def ask_for_action
    puts "Please select an action:"
    puts "1. Add products to cart"
    puts "2. Checkout cart"
    puts "3. Exit program"
    print "> "
    gets.chomp
  end

  def display_products(products)
    puts ""
    puts "Select a product:"
    products.each_with_index do |product, index|
      puts "#{index + 1}. #{product.name} - #{product.price} €"
    end
  end

  def ask_for_product_index
    puts "Enter the number of the product you want to add: "
    print "> "
    gets.chomp
  end

  def ask_for_product_quantity
    puts "Enter the quantity of the product: "
    print "> "
    gets.chomp
  end
end
