# rubocop:disable Lint/RescueException

class InventoryFoodsController < ApplicationController
  def new
    @new_inventory_food = InventoryFood.new
  end

  def create
    inventory_food = InventoryFood.new(inventory_food_params)
    respond_to do |format|
      if inventory_food.save
        flash[:notice] = 'Created an inventory food succesfully'
        format.html { redirect_to "/inventories/#{params[:id]}" }
      else
        flash[:notice] = 'Failed to create an inventory food. Try again'
        format.html { redirect_to "/inventories/#{params[:id]}/inventory_foods/new" }
      end
    end
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  def destroy
    inventory_food = InventoryFood.find(params[:id])
    inventory = inventory_food.inventory
    inventory_food.destroy
    flash[:notice] = 'Inventory food was successfully removed'
    redirect_to "/inventories/#{inventory.id}"
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to not_found_path
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:inventory_id, :food_id, :quantity)
  end
end

# rubocop:enable Lint/RescueException
