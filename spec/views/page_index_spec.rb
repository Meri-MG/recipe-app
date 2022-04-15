require 'rails_helper'

RSpec.describe 'HomePage', type: :system do
  it 'visits home page' do
    visit '/'
    expect(page).to have_content('Welcome')
  end
end