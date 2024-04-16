require_relative '../src/register'

RSpec.describe Register do
  describe '#initialize' do
    it 'loads products from the JSON file' do
      # Create a new instance of Register
      register = Register.new

      # Retrieve the products loaded by Register
      products = register.instance_variable_get(:@products)

      expect(products).not_to be_empty
      expect(products.map(&:code)).to include('GR1', 'SR1', 'CF1')
    end
  end
end
