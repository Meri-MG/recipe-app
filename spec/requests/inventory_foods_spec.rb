require 'rails_helper'

RSpec.describe "InventoryFoods", type: :request do
  context 'testing request' do
    it "GET /inventories/:id/inventory_foods/new" do
      user = User.create!(name: 'Dan')
      inventory = user.inventories.create!(name: "Inv#1")
      get("/inventories/#{inventory.id}/inventory_foods/new")
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it "POST /inventories/:id/inventory_foods" do
      user = User.create!(name: 'Dan')
      inventory = user.inventories.create!(name: "Inv#1")
      food = user.foods.create!(name: 'Apple', measurement_unit: 'grams', price: 321)
      post("/inventories/#{inventory.id}/inventory_foods", params: { inventory_food: { inventory_id: inventory.id, food_id: food.id, quantity: 5.5 } })
      expect(response).to redirect_to("/inventories/#{inventory.id}")
      delete("/inventory_foods/#{InventoryFood.last.id}")
      expect(response).to redirect_to("/inventories/#{inventory.id}")
    end
  end
end
