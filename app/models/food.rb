class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, foreign_key: 'food_id', dependent: :destroy
  has_many :recipes, through: :recipe_foods, dependent: :destroy
  has_many :inventory_foods, foreign_key: 'food_id', dependent: :destroy
  has_many :inventories, through: :inventory_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :measurement_unit, presence: true,
                               inclusion: { in: %w[grams units], message: '%<value>s is not a measurement unit' }
  validates :price, presence: true, comparison: { greater_than: 0 }
end
