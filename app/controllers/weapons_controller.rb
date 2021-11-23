class WeaponsController < ApplicationController
  before_action :check_authorization
  before_action :check_hero_exists
  before_action :find_weapon
  before_action :find_hero
  before_action :check_stock, only: %i[buy]

  def buy
    if @hero.gold < @weapon.price
      flash[:alert] = "You don't have enough gold to pay for that!"
    else
      @hero.update(gold: @hero.gold - @weapon.price)
      unless @weapon.hero.nil?
        seller = @weapon.hero
        seller.update(gold: seller.gold + @weapon.price)
      end
      @weapon.update(hero_id: @hero.id, price: nil)
    end
    redirect_to root_path
  end

  def sell
    approximate_value
    @value /= 2
  end

  def update
    @weapon.update(weapon_params)
    redirect_to root_path
  end

  def buyback
    @weapon.update(price: nil)
    redirect_to root_path
  end

  private

  def check_authorization
    authorize Weapon
  end

  def weapon_params
    params.require(:weapon).permit(:price)
  end

  def find_weapon
    @weapon = Weapon.find(params[:id])
  end

  def find_hero
    @hero = current_user.hero
  end

  def check_stock
    return unless @weapon.price.nil? || @weapon.nil?

    redirect_to root_path notice: 'Sorry, that weapon is no longer for sale.'
  end

  def approximate_value
    @value = (@weapon.type.damage + @weapon.quality.modifier) *
             (@weapon.type.durability + @weapon.quality.modifier - @weapon.uses)
    return if @weapon.enchant.nil?

    @value += (@weapon.enchant.bonus * (@weapon.type.durability + @weapon.quality.modifier - @weapon.uses))
  end
end
