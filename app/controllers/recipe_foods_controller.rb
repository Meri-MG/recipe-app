class RecipeFoodsController < ApplicationController
  def new
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @new_recipe = @recipe.recipe_foods.new(recipe_food_params)
    if @new_recipe.save
      flash[:notice] = 'Ingredient was added successfully.'
      redirect_to recipe_path(@recipe.id)
    else
      flash[:notice] = 'Invalid entries!'
      redirect_to new_recipe_recipe_food_path(@recipe.id)
    end
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])
    recipe = recipe_food.recipe
    recipe_food.destroy
    redirect_to recipe_path(recipe)
    flash[:notice] = 'Ingredient was deleted'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
