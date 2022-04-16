# rubocop:disable Lint/RescueException

class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    @shopping_list = @inventory.compute_missing_foods(@recipe)
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end
end

# rubocop:enable Lint/RescueException
