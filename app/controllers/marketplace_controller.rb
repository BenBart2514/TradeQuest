class MarketplaceController < ApplicationController
  before_action :check_hero_exists
  before_action :find_hero
  before_action :create_inventory
  before_action :build_listings

  def index
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
  end

  def search
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
    @sale_weapons = Weapon.where('name ILIKE ?', "%#{params[:query]}%")
    @sale_items = Item.where('name ILIKE ?', "%#{params[:query]}%")
    render 'index'
  end

  private

  def find_hero
    @hero = current_user.hero
  end

  def build_listings
    @sale_weapons = Weapon.for_sale
    @sale_items = Item.for_sale
  end

  def create_inventory
    @hero_weapons = @hero.weapons.order(:type_id, :name)
    @hero_items = @hero.items.order(:level, :element)
  end
end
