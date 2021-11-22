class ItemsController < ApplicationController
  before_action :check_authorization
  before_action :check_hero_exists
  before_action :find_item
  before_action :find_hero
  before_action :check_stock, only: %i[buy]

  def buy
    if @hero.gold < @item.price
      flash[:alert] = "You don't have enough gold to pay for that!"
    elsif @item.hero.nil?
      @hero.update(gold: @hero.gold - @item.price)
      purchase = Item.create(hero_id: @hero.id, name: @item.name, level: @item.level, element: @item.element)
      purchase.image.attach(io: File.open("app/assets/images/#{@item.element}#{@item.level}.png"),
                            filename: "#{@item.element}#{@item.level}.png", content_type: 'image/png')
    else
      seller = @item.hero
      @hero.update(gold: @hero.gold - @item.price)
      seller.update(gold: seller.gold + @item.price)
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

  def check_stock
    return unless @item.price.nil? || @item.nil?

    redirect_to root_path notice: 'Sorry, that item is no longer for sale.'
  end
end
