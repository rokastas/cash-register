require_relative '../src/app'

RSpec.describe App do
  describe '#load_products' do
    it 'loads products from the JSON file' do
      products = Product.all

      expect(products).not_to be_empty
      expect(products.map(&:code)).to include('GR1', 'SR1', 'CF1')
    end
  end
end
