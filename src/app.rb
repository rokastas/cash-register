require_relative 'register'
require_relative 'userInterface'

class App
  def initialize
    # Create a new instance of the user interface
    @user_interface = UserInterface.new

    # Create a new instance of the register
    @register = Register.new

    # Retrieve the products loaded by the register
    @products = @register.products
  end

  def start
    # Display welcome message
    @user_interface.display_welcome_message

    loop do
      # Gets user choice
      user_action = @user_interface.ask_for_action

      case user_action
        when '1' # Add products to cart
          # Displays the list of products
          @user_interface.display_products(@products)

          # Asks the user for the product index
          product_index = @user_interface.ask_for_product_index.to_i - 1

          # Ask the user for the quantity
          product_quantity = @user_interface.ask_for_product_quantity.to_i

          # Add the product to the cart
          @register.add_to_cart(@products[product_index], product_quantity)

          # Display the current cart
          @user_interface.display_cart(@register)

        when '2' # Checkout the cart and exit

          @user_interface.display_cart(@register)
          puts 'Goodbye!'
          break

        else
          puts ''
          puts 'Invalid action. Please try again.'
          puts ''
      end
    end
  end
end

# Guard clause to prevent execution when required as a module
if $PROGRAM_NAME == __FILE__
  # Create an instance of the App class and start the application
  app = App.new
  app.start
end
