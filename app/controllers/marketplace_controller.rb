class MarketplaceController < ApplicationController
  def index
    if current_user.hero == nil
      redirect_to new_hero_path
    end
    @page_name = "Marketplace"
    @top_link = "Go Questing"
    @link_path = questing_path
  end
end
