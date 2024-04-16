require_relative '../src/register'

RSpec.describe Register do
  describe '#initialize' do
    it 'loads products from the JSON file' do
      register = Register.new
      products = register.products

      expect(products).not_to be_empty
      expect(products.map(&:code)).to include('GR1', 'SR1', 'CF1')
    end
  end

  describe '#add_to_cart' do
    it 'adds a product to the cart' do
      register = Register.new
      product = register.products.first
      register.add_to_cart(product, 1)

      expect(register.cart).to eq({ product => 1 })
    end

    it 'increments the quantity of a product in the cart' do
      register = Register.new
      product = register.products.first
      register.add_to_cart(product, 1)
      register.add_to_cart(product, 1)

      expect(register.cart).to eq({ product => 2 })
    end
  end
end
