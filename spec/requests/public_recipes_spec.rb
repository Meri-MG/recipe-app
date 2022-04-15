require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  context 'testing request' do
    it 'GET /public_recipes' do
      get('/public_recipes')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end
  end
end
