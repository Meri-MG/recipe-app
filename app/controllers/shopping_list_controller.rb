class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.where(id: params[:recipe_id])[0]
    if @recipe.nil?
      flash[:notice] = 'This recipe doesn\'t exist!'
      redirect_to root_path
      return
    end
    @inventory = Inventory.where(id: params[:inventory_id])[0]
    if @inventory.nil?
      flash[:notice] = 'This inventory doesn\'t exist!'
      redirect_to root_path
      return
    end

    @shopping_list = @inventory.compute_missing_foods(@recipe)
  end
end
