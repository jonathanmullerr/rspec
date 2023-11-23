require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do 
    it 'check the description' do 
      category = create(:category)
      puts category.description
      expect(category.description).not_to be_nil
    end
  end
end
