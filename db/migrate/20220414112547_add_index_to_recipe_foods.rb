class AddIndexToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_index :recipe_foods, [:recipe_id, :food_id], unique: true
  end
end
