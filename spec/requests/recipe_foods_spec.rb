require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  context 'testing request' do
    it 'GET /recipes/:id/recipe_foods/new' do
      user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
      recipe = user.recipes.create!(name: 'Chopped apples', preparation_time: 1, cooking_time: 2,
                                    description: 'In order to cook...')
      sign_in user
      get("/recipes/#{recipe.id}/recipe_foods/new")
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'POST /recipes/:recipe_id/recipe_foods and DELETE /recipes/:recipe_id/recipe_foods/:id' do
      user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
      recipe = user.recipes.create!(name: 'Chopped apples', preparation_time: 1, cooking_time: 2,
                                    description: 'In order to cook...')
      food = user.foods.create!(name: 'Apple', measurement_unit: 'grams', price: 321)
      sign_in user
      post("/recipes/#{recipe.id}/recipe_foods",
           params: { recipe_food: { recipe_id: recipe.id, food_id: food.id, quantity: 6.5 } })
      expect(response).to redirect_to("/recipes/#{recipe.id}")
      delete("/recipes/#{recipe.id}/recipe_foods/#{RecipeFood.last.id}")
      expect(response).to redirect_to("/recipes/#{recipe.id}")
    end
  end
end
