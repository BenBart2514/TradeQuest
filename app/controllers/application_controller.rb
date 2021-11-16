class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def check_hero_exists
    redirect_to new_hero_path if current_user.hero.nil?
  end
end
