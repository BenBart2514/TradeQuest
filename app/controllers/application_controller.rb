class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  def check_hero_exists
    redirect_to new_hero_path if current_user.hero.nil?
  end

  def forbidden
    flash[:alert] = 'You do not have authorization to perform this action'
    redirect_to(request.referrer || root_path)
  end
end
