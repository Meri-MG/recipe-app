require 'rails_helper'

RSpec.describe Inventory, type: :model do
  subject do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    Inventory.new(user:, name: 'An inventory')
  end

  before { subject.save }

  it 'subject should be valid' do
    expect(subject).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:inventory_foods) }
    it { should have_many(:foods).through(:inventory_foods) }
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
  end
end
