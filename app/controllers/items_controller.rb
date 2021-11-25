class ItemsController < ApplicationController
  before_action :check_authorization
  before_action :check_hero_exists
  before_action :find_hero
  before_action :find_item, except: %i[create new]
  before_action :check_stock, only: %i[buy]

  def buy
    if @hero.gold < @item.price
      flash[:alert] = "You don't have enough gold to pay for that!"
    elsif @item.hero.nil?
      @hero.update(gold: @hero.gold - @item.price)
      purchase = Item.create(hero_id: @hero.id, name: @item.name, level: @item.level, element: @item.element)
      purchase.image.attach(io: File.open("app/assets/images/#{@item.element}#{@item.level}.png"),
                            filename: "#{@item.element}#{@item.level}.png", content_type: 'image/png')
    elsif @item.hero == @hero
      buyback and return
    else
      seller = @item.hero
      @hero.update(gold: @hero.gold - @item.price)
      seller.update(gold: seller.gold + @item.price)
      @item.update(hero_id: @hero.id, price: nil)
    end
    redirect_to root_path, notice: "#{@item.name} has been added to your inventory"
  end

  def sell; end

  def buyback
    @item.update(price: nil)
    redirect_to root_path, notice: "#{@item.name} has been removed from the market"
  end

  def update
    @item.update(item_params)
    redirect_to root_path, notice: "#{@item.name} has been updated!"
  end

  def destroy
    @hero.equipment.update(item_id: nil)
    @item.destroy
    redirect_to root_path, notice: "#{@item.name} has been destroyed!"
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.assign_attributes(hero_id: @hero.id)
    begin
      @item.save!
      redirect_to root_path, notice: "#{@item.name} has been created!"
    rescue StandardError
      flash.now[:errors] = @item.errors.messages.values.flatten
      render 'new'
    end
  end

  private

  def check_authorization
    authorize Item
  end

  def item_params
    params.require(:item).permit(:hero_id, :name, :image, :level, :element, :price)
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
