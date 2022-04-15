require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  context 'testing request' do
    it 'GET /foods' do
      get('/foods')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /foods/:id' do
      user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
      food = user.foods.create!(name: 'Apple', measurement_unit: 'grams', price: 321)
      sign_in user
      get("/foods/#{food.id}")
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /foods/new' do
      get('/foods/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'DELETE /foods/:id' do
      user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
      food = user.foods.create!(name: 'Apple', measurement_unit: 'grams', price: 321)
      sign_in user
      delete("/foods/#{food.id}")
      expect do
        get("/foods/#{food.id}")
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to_not render_template('show')
      expect(response).to_not have_http_status(:ok)
    end
  end
end
