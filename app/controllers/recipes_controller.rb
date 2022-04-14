class RecipesController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    @recipes = current_user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @recipe_foods = @recipe.recipe_foods
    @inventories = current_user.inventories
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe was created successfully.'
      redirect_to recipes_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe was deleted successfully.'
    redirect_to recipes_path
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    public = params[:public] == '1'
    @recipe.update_attribute(:public, public)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
