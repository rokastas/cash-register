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
          product_index = @user_interface.ask_for_product_index(@products.length)

          # Ask the user for the quantity
          product_quantity = @user_interface.ask_for_product_quantity.to_i

          # Add the product to the cart
          @register.add_to_cart(@products[product_index], product_quantity)

          # Display the current cart
          @user_interface.display_cart(@register)

        when '2' # Remove products from cart
          if @register.cart.empty?
            # Displays the list of products in the cart (with your cart is empty message)
            @user_interface.display_cart(@register)
          else
            # Displays the list of products in the cart
            @user_interface.display_cart(@register)
            # Asks the user for the product index to remove
            product_to_remove_index = @user_interface.ask_for_product_index(@register.cart.length)
            product_to_remove = @register.cart.keys[product_to_remove_index]
            # Asks the user for the quantity to remove
            product_quantity_in_cart = @register.cart.values[product_to_remove_index]
            product_quantity_to_remove = @user_interface.ask_for_product_quantity_to_remove(product_to_remove, product_quantity_in_cart)

            @register.remove_from_cart(product_to_remove, product_quantity_to_remove)

            # Display the current cart
            @user_interface.display_cart(@register)
          end

        when '3' # Checkout the cart and exit

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
