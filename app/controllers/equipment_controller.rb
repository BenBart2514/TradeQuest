class EquipmentController < ApplicationController
  before_action :check_hero_exists
  
  def update
    permit
    @equipment = Equipment.find(params[:id])
    @weapon = params[:equipment].fetch('weapon_id').to_i if params[:equipment].key?('weapon_id')
    @item = params[:equipment].fetch('item_id').to_i if params[:equipment].key?('item_id')
    if @weapon.zero?
      @equipment.update(weapon_id: nil)
    else
      @equipment.update(weapon_id: @weapon)
    end
    if @item.zero?
      @equipment.update(item_id: nil)
    else
      @equipment.update(item_id: @item)
    end
    redirect_to questing_path
  end

  private

  def permit
    params.require(:equipment).permit!
  end
end
