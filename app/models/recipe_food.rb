class RecipeFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id'
  belongs_to :recipe, foreign_key: 'recipe_id'

  validates :quantity, comparison: { greater_than: 0 }
end
