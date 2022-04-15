require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  it 'creates food' do
    visit '/users/sign_in'
    User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    click_link 'Foods'
    click_link 'Add Food'

    fill_in 'food_name', with: 'orange'
    fill_in 'food_measurement_unit', with: 'grams'
    fill_in 'food_price', with: 2

    click_button 'Create Food'

    expect(page).to have_current_path('/foods')
    expect(page).to have_content('Food created successfully')
    expect(page).to have_content('orange')
    expect(page).to have_content('grams')
    expect(page).to have_content('$2')
  end

  it 'check for foods' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    food1 = user.foods.create(name: 'pineapple', measurement_unit: 'grams', price: 3)
    food2 = user.foods.create(name: 'chicken', measurement_unit: 'units', price: 12)

    click_link 'Foods'

    expect(page).to have_content(food1.name)
    expect(page).to have_content(food1.measurement_unit)
    expect(page).to have_content('$3')

    expect(page).to have_content(food2.name)
    expect(page).to have_content(food2.measurement_unit)
    expect(page).to have_content('$12')
  end

  it 'food details page' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    food1 = user.foods.create(name: 'pineapple', measurement_unit: 'grams', price: 3)

    click_link 'Foods'

    click_link 'Show'

    expect(page).to have_content(food1.name)
    expect(page).to have_content(food1.measurement_unit)
    expect(page).to have_content('$3')
  end

  it 'removes food' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    food1 = user.foods.create(name: 'pineapple', measurement_unit: 'grams', price: 3)

    click_link 'Foods'

    click_button 'Delete'

    expect(page).to_not have_content('pineapple')
    expect(page).to_not have_content('grams')
    expect(page).to_not have_content('$3')
  end
end