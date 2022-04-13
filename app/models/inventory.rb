class Inventory < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :inventory_foods, foreign_key: 'food_id', dependent: :destroy
  has_many :foods, through: :inventory_foods, dependent: :destroy
end