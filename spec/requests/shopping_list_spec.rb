require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  context 'testing request' do
    it 'GET /public_recipes' do
      user = User.create!(name: 'Dan')
      inventory = user.inventories.create!(name: 'Inv#1')
      recipe = user.recipes.create!(name: 'Chopped apples', preparation_time: 1, cooking_time: 2,
                                    description: 'In order to cook...')
      get('/shopping_list', params: { inventory_id: inventory.id, recipe_id: recipe.id })
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end
  end
end
