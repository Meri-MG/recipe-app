class ShoppingListController < ApplicationController
  def index
    begin
      @recipe = Recipe.find(params[:recipe_id])
      @inventory = Inventory.find(params[:inventory_id])
      @shopping_list = @inventory.compute_missing_foods(@recipe)
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to not_found_path
    end
  end
end
