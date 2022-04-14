class AddIndexToInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    add_index :inventory_foods, [:inventory_id, :food_id], unique: true
  end
end
