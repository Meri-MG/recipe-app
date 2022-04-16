class InventoriesController < ApplicationController
  def index
    @inventories = if current_user.nil?
                     []
                   else
                     current_user.inventories
                   end
  end

  def show
    begin
      @inventory = Inventory.find(params[:id])
      @inventory_foods = @inventory.inventory_foods.includes(:food)
    rescue
      flash[:notice] = 'Inventory doesn\'t exist!'
      redirect_to not_found_path
    end
  end

  def destroy
    begin
      current_user.inventories.find(params[:id]).destroy
      flash[:notice] = 'Inventory was successfully removed'
      splitted_path = request.path.split('/')
      splitted_path.pop
      redirect_to splitted_path.join('/')
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to not_found_path
    end
  end

  def new
    @new_inventory = Inventory.new
  end

  def create
    begin
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
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to not_found_path
    end
  end
end
