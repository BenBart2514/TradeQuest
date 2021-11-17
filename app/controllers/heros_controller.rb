class HerosController < ApplicationController
  before_action :check_authorization

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
      Equipment.create(hero_id: @hero.id)
      Weapon.create(hero_id: @hero.id, name: 'Old Sword', quality: Quality.find(1), type: Type.find(5), uses: 0)
      first.image.attach(io: File.open('app/assets/images/Sword.png'),
                         filename: 'Sword.png', content_type: 'image/png')
      redirect_to root_path
    rescue StandardError
      flash[:alert] = @hero.errors.full_messages.flatten.join(', ')
      render 'new'
    end
  end

  private

  def check_authorization
    authorize Hero
  end

  def hero_params
    params.require(:hero).permit(:name)
  end
end
