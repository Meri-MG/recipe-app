class FoodsController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
    @user = @food.user
  end

  def new
    @food = Food.new
  end

  def create
    food = current_user.foods.new(food_params)

    if food.save
      flash[:notice] = 'Food created successfully. 👍'
      redirect_to foods_path(foods_path)
    else
      flash[:notice] = 'Food creation failed. Try again'
      format.html { render :new }
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:success] = 'Food deleted successfully.'
    redirect_to foods_path(foods_path)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
