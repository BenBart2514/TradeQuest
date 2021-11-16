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
    @hero.update(user_id: current_user.id, life: 5, gold: 500, renown: 0, quest_id: rand(1..4))
    begin
      @hero.save!
      new_equip = Equipment.create(hero_id: @hero.id)
      Weapon.create(hero_id: @hero.id, name: 'Old Sword', quality_id: 1, type_id: 5, uses: 0)
      redirect_to root_path
    rescue StandardError
      flash[:alert] = @hero.errors.full_messages.flatten.join(', ')
      new_equip.destroy
      render 'new'
    end
  end

  private

  def hero_params
    params.require(:hero).permit(:name)
  end
end
