require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'testing request' do
    it 'GET /recipes' do
      User.create!(name: 'Dan')
      get('/recipes')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /recipes/:id' do
      user = User.create!(name: 'Dan')
      recipe = user.recipes.create!(name: 'Chopped apples', preparation_time: 1, cooking_time: 2,
                                    description: 'In order to cook...')
      get("/recipes/#{recipe.id}")
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /recipes/new' do
      get('/recipes/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'POST /recipes' do
      User.create!(name: 'Amkam')
      post('/recipes',
           params: { recipe: { name: 'Recipe #n', preparation_time: 1.0, cooking_time: 2.0, description: 'Blah...',
                               public: '1' } })
      get("/recipes/#{Recipe.last.id}")
      expect(Recipe.last.name).to eq 'Recipe #n'
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it 'DELETE /recipes/:id' do
      user = User.create!(name: 'Amkam')
      recipe = user.recipes.create!(name: 'Chopped apples', preparation_time: 1, cooking_time: 2,
                                    description: 'In order to cook...')
      delete("/recipes/#{recipe.id}")
      expect do
        get("/recipes/#{recipe.id}")
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to_not render_template('show')
      expect(response).to_not have_http_status(:ok)
    end
  end
end
