require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'create recipe_food instance' do
    subject do
      user = User.create(name: 'User')
      food = Food.create(name: 'food', measurement_unit: 'grams', price: 10, user:)
      recipe = Recipe.create(name: 'Recipe', preparation_time: 1.0, cooking_time: 1.0, description: 'recipe steps',
                             public: true)
      RecipeFood.new(quantity: 10, recipe:, food:)
    end

    it 'subject should be valid' do
      expect(subject).to be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it 'isn\'t valid without quantity attribute' do
      subject.quantity = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with value less than 1' do
      subject.quantity = 0
      expect(subject).to_not be_valid
    end
  end
end
