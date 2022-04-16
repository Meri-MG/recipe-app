class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    begin
      @food = Food.find(params[:id])
      @user = @food.user
    rescue
      flash[:notice] = 'This food doesn\'t exist!'
      redirect_to not_found_path
    end
  end

  def new
    @food = Food.new
  end

  def create
    begin
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
  end

  def destroy
    begin
      @food = Food.find(params[:id])
      @food.destroy
      flash[:notice] = 'Food deleted successfully.'
      redirect_to foods_path(foods_path)
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to not_found_path
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
