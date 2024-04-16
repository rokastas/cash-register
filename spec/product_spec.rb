require_relative '../src/product'

RSpec.describe Product do
  let(:product) { Product.new('GR1', 'Green Tea', 3.11) }

  describe '#initialize' do
    it 'sets the code, name, and price attributes' do
      expect(product.code).to eq('GR1')
      expect(product.name).to eq('Green Tea')
      expect(product.price).to eq(3.11)
    end
  end
end
