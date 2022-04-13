class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, foreign_key: 'recipe_id', dependent: :destroy
  has_many :foods, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :preparation_time, presence: true, comparison: { greater_than: 0 }
  validates :cooking_time, presence: true, comparison: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 3, maximum: 300 }
  validates :public, presence: true

end
