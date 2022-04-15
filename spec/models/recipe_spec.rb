require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    Recipe.new(user:, name: 'recipe', preparation_time: 1.0, cooking_time: 1.0, description: 'recipe steps',
               public: true)
  end

  before { subject.save }

  it 'subject should be valid' do
    expect(subject).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:recipe_foods) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    it 'isn\'t valid without name' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with name less than 3 characters' do
      subject.name = 'ha'
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with no preparation time' do
      subject.preparation_time = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with wrong value for preparation time' do
      subject.preparation_time = 0
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with no cooking time' do
      subject.cooking_time = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with wrong value for cooking time' do
      subject.cooking_time = -1
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid without public attribute' do
      subject.public = nil
      expect(subject).to_not be_valid
    end
  end
end
