class Inventory < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :inventory_foods, foreign_key: 'inventory_id', dependent: :destroy
  has_many :foods, through: :inventory_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  def compute_missing_foods(recipe)
    shopping_list = []
    recipe.recipe_foods.each do |recipe_food|
      food = recipe_food.food
      inventory_food = inventory_foods.where(food_id: food.id)[0]
      unless inventory_food
        shopping_list << [food.name, "#{recipe_food.quantity} #{food.measurement_unit}",
                          recipe_food.quantity * food.price]
        next
      end
      quantity_needed = recipe_food.quantity - inventory_food.quantity
      quantity_needed = 0 if quantity_needed.negative?
      if inventory_food && quantity_needed != 0
        shopping_list << [food.name, "#{quantity_needed} #{food.measurement_unit}", quantity_needed * food.price]
      end
    end
    shopping_list
  end
end
