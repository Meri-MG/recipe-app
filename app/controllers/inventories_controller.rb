class InventoriesController < ApplicationController
  def index
    @inventories = current_user.inventories
  end

  def show
    @inventory = Inventory.find(params[:id])
    @inventory_foods = @inventory.inventory_foods
  end

  def destroy
    current_user.inventories.find(params[:id]).destroy
    flash[:notice] = 'Inventory was successfully removed'
    splitted_path = request.path.split('/')
    splitted_path.pop
    redirect_to splitted_path.join('/')
  end

  def new
    @new_inventory = Inventory.new
  end

  def create
    inventory = Inventory.new(user: current_user, name: params[:inventory][:name])
    respond_to do |format|
      if inventory.save
        flash[:notice] = 'Created an inventory succesfully'
        format.html { redirect_to '/inventories' }
      else
        flash[:notice] = 'Failed to create an inventory. Try again'
        format.html { redirect_to '/inventories/new' }
      end
    end
  end
end
