class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    @shopping_list = @inventory.compute_missing_foods(@recipe)
  end
end
