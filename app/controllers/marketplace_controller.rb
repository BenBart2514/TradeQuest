class MarketplaceController < ApplicationController
  def index
    if current_user.hero == nil
      redirect_to new_hero_path
    end
  end
end
