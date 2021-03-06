# rubocop:disable Lint/RescueException

class RecipesController < ApplicationController
  def index
    @recipes = if current_user.nil?
                 []
               else
                 current_user.recipes
               end
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @recipe_foods = @recipe.recipe_foods.includes(:food)
    @inventories = if current_user.nil?
                     []
                   else
                     current_user.inventories
                   end
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe was created successfully.'
      redirect_to recipes_path
    else
      render 'new', status: :unprocessable_entity
    end
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe was deleted successfully.'
    redirect_to recipes_path
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    public = params[:public] == '1'
    @recipe.update_attribute(:public, public)
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end

# rubocop:enable Lint/RescueException
