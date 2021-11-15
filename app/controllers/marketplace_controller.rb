class MarketplaceController < ApplicationController
  before_action :build_listings
  before_action :find_hero

  def index
    redirect_to new_hero_path if current_user.hero.nil?
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
  end

  private

  def build_listings
    @sale_weapons = []
    @sale_items = []

    Weapon.all.each do |weapon|
      @sale_weapons << weapon unless weapon.price.nil? || weapon.hero_id == current_user.hero.id
    end

    Item.all.each do |item|
      @sale_items << item unless item.price.nil? || item.hero_id == current_user.hero.id
    end
  end

  def find_hero
    @hero = current_user.hero
  end
end
