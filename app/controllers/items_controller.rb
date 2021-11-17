class ItemsController < ApplicationController
  before_action :check_authorization
  before_action :check_hero_exists
  before_action :find_item
  before_action :find_hero

  def buy
    if @hero.gold < @item.price
      # display message about user hero not having enough gold
    else
      # remove gold form buyer and add to seller
      @hero.update(gold: @hero.gold - @item.price)
      unless @item.hero.nil?
        seller = @item.hero
        seller.update(gold: seller.gold + @item.price)
      end
      # remove item from seller and add item to user's hero and update price to nil to remove from marketplace
      @item.update(hero_id: @hero.id, price: nil)
    end
    redirect_to root_path
  end

  def sell; end

  def update
    @item.update(item_params)
    redirect_to root_path
  end

  def buyback
    @item.update(price: nil)
    redirect_to root_path
  end

  private

  def check_authorization
    authorize Item
  end

  def item_params
    params.require(:item).permit(:price)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def find_hero
    @hero = current_user.hero
  end
end
