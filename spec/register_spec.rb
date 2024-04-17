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

  describe '#total_cart_price' do
    it 'returns the total price of two items' do
      register = Register.new
      register.add_to_cart(register.products.find { |product| product.code == 'GR1' }, 1)
      register.add_to_cart(register.products.find { |product| product.code == 'SR1' }, 1)

      expect(register.total_cart_price).to eq(8.11)
    end

    it 'returns the total discounted price with BOGO promotion applied to Green Tea' do
      register = Register.new
      register.add_to_cart(register.products.find { |product| product.code == 'GR1' }, 2)

      expect(register.total_cart_price).to eq(3.11)
    end

    it 'returns the total discounted price with BulkDiscount promotion applied to Strawberries' do
      register = Register.new
      register.add_to_cart(register.products.find { |product| product.code == 'SR1' }, 3)

      expect(register.total_cart_price).to eq(13.50)
    end

    it 'returns the total discounted price with BulkDiscount promotion applied to Coffee' do
      register = Register.new
      register.add_to_cart(register.products.find { |product| product.code == 'CF1' }, 2)

      expect(register.total_cart_price).to eq(22.46)
    end

    it 'returns the total discounted price with all promotions applied' do
      register = Register.new
      register.add_to_cart(register.products.find { |product| product.code == 'GR1' }, 3)
      register.add_to_cart(register.products.find { |product| product.code == 'SR1' }, 3)
      register.add_to_cart(register.products.find { |product| product.code == 'CF1' }, 3)

      expect(register.total_cart_price.round(2)).to eq(42.18)
    end

    it 'calculated the prices of test_data carts' do
      register = Register.new

      test_data_file = File.read('data/test_data.json')
      tests = JSON.parse(test_data_file)

      tests.each do |test_case|
        test_case['cart'].each do |product_code|
          product = register.products.find { |p| p.code == product_code }
          register.add_to_cart(product, 1)
        end

        expect(register.total_cart_price.round(2)).to eq(test_case['total_cart_price'])
        register.cart.clear
      end
    end
  end
end
