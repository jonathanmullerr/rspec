require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it "is valid with valid attributes" do
      customer = create(:customer)
      expect(customer).to be_valid
    end

    it "is not valid without a name" do
      customer = build(:customer, name: nil)
      expect(customer).to_not be_valid
    end
  end
end
