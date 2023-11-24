require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it 'is valid with description, price and category' do
      product = create(:product)
      expect(product).to be_valid
    end

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }
    
    # %w[price category description].each do |attribute|
    #   it "is invalid without #{attribute}" do
    #     product_with_missing_attribute = build(:product, attribute.to_sym => nil)
    #     product_with_missing_attribute.valid?
    #     expect(product_with_missing_attribute.errors[attribute]).to include("can't be blank")
    #   end
    # end
  end

  context 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  context 'instance methods' do
    it '#full_description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end
end
