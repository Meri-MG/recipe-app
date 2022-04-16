require 'rails_helper'

RSpec.describe 'Inventory', type: :system do
  it 'goes to inventories page' do
    visit '/users/sign_in'
    User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    click_link 'Inventories'

    expect(page).to have_content('Inventory list')
  end

  it 'adds inventory' do
    visit '/users/sign_in'
    User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    click_link 'Inventories'

    click_button 'Add inventory'

    fill_in 'inventory_name', with: 'Inventory 1'

    click_button 'Create Inventory'

    expect(page).to have_content('Inventory 1')
  end

  it 'adds food to an inventory' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    inventory = user.inventories.create!(name: 'Inventory 1')
    food1 = user.foods.create!(name: 'pineapple', measurement_unit: 'grams', price: 3)
    user.foods.create!(name: 'chicken', measurement_unit: 'units', price: 12)

    click_link 'Inventories'

    expect(page).to have_content(inventory.name)

    click_link inventory.name

    expect(page).to have_current_path("/inventories/#{inventory.id}")
    expect(page).to have_content(inventory.name)

    click_button 'Add food'

    find(:css, '#inventory_food_food_id').find(:option, 'pineapple').select_option
    fill_in 'inventory_food_quantity', with: 14

    click_button 'Create Inventory food'

    expect(page).to have_current_path("/inventories/#{inventory.id}")

    expect(page).to have_content(food1.name)
    expect(page).to have_content(food1.measurement_unit)
  end

  it 'removes food from inventory' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    inventory = user.inventories.create!(name: 'Inventory 1')
    food = user.foods.create!(name: 'pineapple', measurement_unit: 'grams', price: 3)
    InventoryFood.create!(quantity: 50, inventory:, food:)

    visit "/inventories/#{inventory.id}"

    expect(page).to have_content(food.name)
    expect(page).to have_content(food.measurement_unit)

    click_button 'Remove'

    expect(page).to_not have_content(food.name)
    expect(page).to_not have_content(food.measurement_unit)
  end

  it 'removes inventory' do
    visit '/users/sign_in'
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    inventory = user.inventories.create!(name: 'Inventory 1')

    click_link 'Inventories'

    expect(page).to have_content(inventory.name)

    click_button 'Remove'

    expect(page).to_not have_content(inventory.name)
  end
end
