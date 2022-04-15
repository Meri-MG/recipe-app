require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  it 'shows the static text' do
    visit '/'
    expect(page).to have_content('Welcome')
  end
end