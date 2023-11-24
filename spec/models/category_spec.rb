require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do 
    it 'is valid with description' do 
      category = create(:category)
      expect(category.description).not_to be_nil
    end

    it 'is invalid without description' do
      category = build(:category, description: nil)
      category.valid?
      expect(category.errors[:description]).to include("can't be blank")
    end
  end

  context 'associations' do
    it  { is_expected.to have_many(:products) }
  end
end
