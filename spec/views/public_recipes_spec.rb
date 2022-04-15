require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :system do
  it 'goes to public recipes page' do
    visit '/users/sign_in'
    user1 = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    user2 = User.create!(name: 'Badman', email: 'blahblah@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    recipe1 = user1.recipes.create!(name: 'Galaretka', description: 'Polish dish', preparation_time: 5, cooking_time: 6)
    recipe2 = user2.recipes.create!(name: 'Borshch', description: 'Ukrainian dish', preparation_time: 2, cooking_time: 3)

    click_link 'Public Recipes'

    expect(page).to have_content(recipe1.name)

    expect(page).to have_content(recipe2.name)
  end
end