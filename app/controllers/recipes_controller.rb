class RecipesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.author
  end

  def create
    recipe = current_user.recipes.new(recipe_params)
    if recipe.save
      flash[:notice] = 'Recipe was created successfully.'
      redirect_to
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    flash[:notice] = 'Recipe was deleted successfully.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
