require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  describe 'create Inventory food instance' do
    subject {
      user = User.create(name: 'User')
      food = Food.create(name: 'food', measurement_unit: 'grams', price: 10, user:user )
      inventory= Inventory.create(name: 'Recipe', user: user)
      InventoryFood.new(quantity: 10, inventory: inventory, food: food)
    }

    it 'subject should be valid' do
      expect(subject).to be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:inventory) }
    it { should belong_to(:food) }
  end

  describe 'validations' do 
    it 'isn\'t valid with value less than 1' do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end
  end
end
