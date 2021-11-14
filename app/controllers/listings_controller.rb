class ListingsController < ApplicationController
  before_action :build_listings

  def index
    redirect_to new_hero_path if current_user.hero.nil?
    @page_name = 'Marketplace'
    @top_link = 'Questing'
    @link_path = questing_path
  end

  def build_listings
    @sale_weapons = []
    @sale_items = []

    Weapon.all.each do |weapon|
      @sale_weapons << weapon unless weapon.price.nil?
    end

    Item.all.each do |item|
      @sale_items << item unless item.price.nil?
    end
  end
end
