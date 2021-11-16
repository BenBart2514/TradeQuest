class WeaponsController < ApplicationController
  before_action :check_hero_exists
  before_action :find_weapon
  before_action :find_hero

  def buy
    if @hero.gold < @weapon.price
      # display message about user hero not having enough gold
    else
      # remove gold form buyer and add to seller
      @hero.update(gold: @hero.gold - @weapon.price)
      unless @weapon.hero.nil?
        seller = @weapon.hero
        seller.update(gold: seller.gold + @weapon.price)
      end
      # remove weapon from seller and add weapon to user's hero and update price to nil to remove from marketplace
      @weapon.update(hero_id: @hero.id, price: nil)
    end
    redirect_to root_path
  end

  def sell; end

  def update
    @weapon.update(weapon_params)
    redirect_to root_path
  end

  def buyback
    @item.update(price: nil)
    redirect_to root_path
  end

  private

  def weapon_params
    params.require(:weapon).permit(:price)
  end

  def find_weapon
    @weapon = Weapon.find(params[:id])
  end

  def find_hero
    @hero = current_user.hero
  end
end
