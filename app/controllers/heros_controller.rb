class HerosController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    if current_user.hero.nil?
      @hero = Hero.new
    else
      redirect_to root_path
    end
  end

  def create
    @hero = Hero.new(hero_params)
    @hero.update(user_id: current_user.id, life: 5, gold: 50, renown: 0)
    begin
      @hero.save!
      redirect_to root_path
    rescue StandardError
      flash[:alert] = @hero.errors.full_messages.flatten.join(', ')
      render 'new'
    end
  end

  private

  def hero_params
    params.require(:hero).permit(:name)
  end
end
