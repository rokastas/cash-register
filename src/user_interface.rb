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
end
