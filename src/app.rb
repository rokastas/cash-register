require_relative 'register'
require_relative 'userInterface'

class App
  def initialize
    @user_interface = UserInterface.new
    @register = Register.new
    @products = @register.products
  end

  def start
    @user_interface.display_welcome_message

    loop do
      user_action = @user_interface.ask_for_action

      case user_action
      when '1' # Add products to cart
        add_product_to_cart

      when '2' # Remove products from cart
        remove_product_from_cart

      when '3' # Checkout the cart and exit
        @user_interface.display_cart(@register)
        puts 'Goodbye!'
        break

      else
        @user_interface.display_invalid_action_message
      end
    end
  end

  private

  def add_product_to_cart
    @user_interface.display_products(@products)
    product_index = @user_interface.ask_for_product_index(@products.length)
    product_quantity = @user_interface.ask_for_product_quantity.to_i
    @register.add_to_cart(@products[product_index], product_quantity)
    @user_interface.display_cart(@register)
  end

  def remove_product_from_cart
    if @register.cart.empty?
      @user_interface.display_empty_cart_message
    else
      @user_interface.display_cart(@register)
      product_to_remove_index = @user_interface.ask_for_product_index(@register.cart.length)
      product_to_remove = @register.cart.keys[product_to_remove_index]
      product_quantity_in_cart = @register.cart.values[product_to_remove_index]
      product_quantity_to_remove = @user_interface.ask_for_product_quantity_to_remove(product_to_remove, product_quantity_in_cart)

      @register.remove_from_cart(product_to_remove, product_quantity_to_remove)
      @user_interface.display_cart(@register)
    end
  end
end

# Guard clause to prevent execution when required as a module
if $PROGRAM_NAME == __FILE__
  app = App.new
  app.start
end
