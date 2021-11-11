class HerosController < ApplicationController
    def new
        @hero = Hero.new
    end

    def create
        @hero = Hero.new(hero_params)
        @hero.update(user_id: current_user.id, life: 5, gold: 50, renown: 0)
        @hero.save!
        redirect_to root_path
    end

    private

    def hero_params
      params.require(:hero).permit(:name)
    end
end
