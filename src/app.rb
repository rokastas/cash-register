require_relative 'product'
require_relative 'register'
require_relative 'user_interface'

class App
  def initialize
    # Create a new instance of the user interface
    @user_interface = User_interface.new

    # Create a new instance of the register
    @register = Register.new
  end

  def start
    # Display welcome message
    @user_interface.display_welcome_message

    loop do
      # Gets user choice
      user_action = @user_interface.ask_for_action

      case user_action
      when '1'
        # Displays the list of products, lets the user select a product
        # (and its quantity) to add to the cart
        puts ''
        puts 'Adding products to the cart...'
        puts ''
      when '2'
        # Checks out the cart and displays the total price
        puts ''
        puts 'Checking out the cart...'
        puts ''
      when '3'
        # Exits the program
        puts ''
        puts 'Exiting the program...'
        puts ''
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
