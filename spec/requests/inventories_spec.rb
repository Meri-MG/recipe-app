require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  describe 'testing request' do
    it 'GET /inventories' do
      User.create!(name: 'Dan')
      get('/inventories')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /inventories/:id' do
      user = User.create!(name: 'Dan')
      user.inventories.create!(name: 'Inventory #1')
      inventory2 = user.inventories.create!(name: 'Inventory #2')
      get("/inventories/#{inventory2.id}")
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /inventories/new' do
      get('/inventories/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'POST /inventories' do
      User.create!(name: 'Amkam')
      post('/inventories', params: { inventory: { name: 'Inventory #n' } })
      get("/inventories/#{Inventory.last.id}")
      expect(Inventory.last.name).to eq 'Inventory #n'
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it 'DELETE /inventories/:id' do
      user = User.create!(name: 'Amkam')
      inventory = user.inventories.create!(name: 'Inventory #m')
      delete("/inventories/#{inventory.id}")
      expect do
        get("/inventories/#{inventory.id}")
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to_not render_template('show')
      expect(response).to_not have_http_status(:ok)
    end
  end
end
