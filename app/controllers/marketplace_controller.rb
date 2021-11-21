class MarketplaceController < ApplicationController
  before_action :check_hero_exists
  before_action :find_hero

  def index
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
    @weapons = Weapon.all
    @items = Item.all
    build_listings
  end

  def search
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
    @weapons = Weapon.where('name ILIKE ?', "%#{params[:query]}%")
    @items = Item.where('name ILIKE ?', "%#{params[:query]}%")
    build_listings
    render 'index'
  end

  private

  def build_listings
    @sale_weapons = []
    @sale_items = []

    @weapons.each do |weapon|
      @sale_weapons << weapon unless weapon.price.nil? || weapon.hero_id == current_user.hero.id
    end

    @items.each do |item|
      @sale_items << item unless item.price.nil? || item.hero_id == current_user.hero.id
    end
  end

  def find_hero
    @hero = current_user.hero
  end
end
