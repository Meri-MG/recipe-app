# rubocop:disable Lint/RescueException

class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
    @user = @food.user
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.foods.new(food_params)

    if food.save
      flash[:notice] = 'Food created successfully. 👍'
      redirect_to foods_path
    else
      flash[:notice] = 'Food creation failed. Try again'
      redirect_to new_food_path
    end
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = 'Food deleted successfully.'
    redirect_to foods_path(foods_path)
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end

# rubocop:enable Lint/RescueException
