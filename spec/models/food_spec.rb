require 'rails_helper'

RSpec.describe Food, type: :model do
  subject do
    user = User.create(name: 'User')
    Food.new(user:, name: 'A post', measurement_unit: 'grams', price: 10)
  end

  before { subject.save }

  it 'subject should be valid' do
    expect(subject).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:recipe_foods) }
    it { should have_many(:recipes).through(:recipe_foods) }
    it { should have_many(:inventory_foods) }
    it { should have_many(:inventories).through(:inventory_foods) }
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

    it 'isn\'t valid with no measurement_unit' do
      subject.measurement_unit = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with wrong measurement_unit' do
      subject.measurement_unit = 'kg'
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with no price' do
      subject.price = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with no price' do
      subject.price = -1
      expect(subject).to_not be_valid
    end
  end
end
