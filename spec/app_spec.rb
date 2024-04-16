require_relative '../src/app'

RSpec.describe App do
  describe '#initialize' do
    it 'initializes the register with products' do
      # Create a new instance of the App class
      app = App.new

      # Retrieve the products loaded by the register
      products = app.instance_variable_get(:@products)

      expect(products).not_to be_empty
      expect(products.map(&:code)).to include('GR1', 'SR1', 'CF1')
    end
  end
end
