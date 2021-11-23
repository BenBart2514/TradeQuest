class QuestsController < ApplicationController
  before_action :check_authorization
  before_action :check_hero_exists
  before_action :find_hero
  before_action :find_quest, only: %i[index result]
  before_action :find_equipment, only: %i[index result]
  before_action :set_weapon, only: %i[index result]
  before_action :set_item, only: %i[index result]
  before_action :determine_success, only: %i[index result]

  def index
    @page_name = 'Questing'
    @top_link = 'Marketplace'
    @link_path = root_path
    calc_remaining_uses
  end

  def result
    @marked_for_death = false
    @weapon_drop = false
    @success = false
    @bonus = false
    success_roll
    fate_roll
    gr_change
    bonus if @bonus == true
    reward if @success == true
    destroy_item unless @current_item == 'None'
    damage_weapon unless @current_weapon == 'None'
    @hero.update(quest_id: rand(1..4))

    p 'death, weapon, success, bonus'
    p @marked_for_death
    p @weapon_drop
    p @success
    p @bonus

    if @marked_for_death == true
      @equipment.update(weapon_id: nil, item_id: nil)
      @equipment.destroy
      @hero.destroy
      redirect_to questing_path, notice: 'You died... but the gods offer you another chance to live a new life.'
    elsif @success == true
      if @bonus == true && @weapon_drop == false
        flash[:alert] =
          "#{@reward.name} was added to your inventory. You also claimed a #{@bonus_loot.name} on the journey!"
      elsif @bonus == true && @weapon_drop == true
        flash[:alert] =
          "#{@new_weapon.name} and one #{@reward.name} was added to your inventory. You also claimed a #{@bonus_loot.name} on the journey!"
      elsif @bonus == false && @weapon_drop == true
        flash[:alert] =
          "#{@new_weapon.name} and one #{@reward.name} was added to your inventory."
      else
        flash[:alert] = "#{@reward.name} was added to your inventory."
      end
      redirect_to questing_path, notice: "Quest Successful! You've earned #{@result} Gold and Renown."
    elsif bonus == true && @success == false
      flash[:alert] = "However, you managed to find a #{@bonus_loot.name} on your way home!"
      redirect_to questing_path, notice: "Quest Failed! #{@hero.name} lost 50 Gold 1 Life point."
    else
      redirect_to questing_path, notice: "Quest Failed! #{@hero.name} lost 50 Gold 1 Life point."
    end
  end

  def skip
    if @hero.gold < 25
      flash[:alert] = 'You do not have enough gold to pay for lodgings!'
    else
      @hero.update(gold: @hero.gold - 25, quest_id: rand(1..4))
      if @hero.life == 5
        flash[:alert] = "You feel well-rested, #{@hero.name} lost 25 Gold."
      else
        @hero.update(life: @hero.life + 1)
        flash[:alert] = if @hero.life == 5
                          "Your wounds have completely healed, #{@hero.name} lost 25 Gold and gained 1 Life point."
                        else
                          "Your wounds are healing... #{@hero.name} lost 25 Gold and gained 1 Life point."
                        end
      end
    end
    redirect_to questing_path
  end

  private

  def check_authorization
    authorize Quest
  end

  def find_hero
    @hero = current_user.hero
  end

  def find_quest
    @quest = Quest.find(@hero.quest_id)
  end

  def find_equipment
    @equipment = Equipment.find_by(hero_id: @hero.id)
  end

  def set_weapon
    @current_weapon = if @equipment.weapon_id.nil?
                        'None'
                      else
                        Weapon.find(@equipment.weapon_id)
                      end
  end

  def set_item
    @current_item = if @equipment.item_id.nil?
                      'None'
                    else
                      Item.find(@equipment.item_id)
                    end
  end

  def determine_success
    calc_remaining_uses
    @weapon_rating = 0
    @item_rating = 0
    unless @current_weapon == 'None'
      @base_bonus = @current_weapon.type.damage + @current_weapon.quality.modifier + @remaining_uses
      @enchant_bonus = if @current_weapon.enchant.nil?
                         0
                       elsif @current_weapon.enchant.imbue == @quest.element || @current_weapon.enchant.imbue == @quest.resistance
                         @current_weapon.enchant.bonus / 2
                       elsif @current_weapon.enchant.imbue == @quest.weakness
                         @current_weapon.enchant.bonus * 1.5
                       else
                         @current_weapon.enchant.bonus
                       end
      @weapon_rating = @base_bonus + @enchant_bonus.to_i
    end
    unless @current_item == 'None'
      if @current_item.level == 1 && @current_item.element == @quest.weakness
        @item_rating = 20
      elsif @current_item.level == 2
        @item_rating = if @current_item.element == @quest.weakness
                         40
                       elsif @current_item.element == @quest.element || @current_item.element == @quest.resistance
                         10
                       else
                         20
                       end
      elsif @current_item.level == 3
        @item_rating = if @current_item.element == @quest.weakness
                         60
                       elsif @current_item.element == @quest.element || @current_item.element == @quest.resistance
                         15
                       else
                         30
                       end
      else
        @item_rating = 5
      end
    end
    @true_success_chance = @weapon_rating + @item_rating
    @success_chance = if @true_success_chance > 95
                        95
                      elsif @true_success_chance < 5
                        5
                      else
                        @true_success_chance
                      end
  end

  def success_roll
    @roll = rand(1..100)
    @result = @roll + @true_success_chance
    @success = true if @result >= 100
    @bonus = true if @result > 200
  end

  def fate_roll
    @fate = rand(1..20)
    case @fate
    when 1
      @success = false
    when 20
      @success = true
    end
  end

  def gr_change
    if @success == true
      @hero.gold += (@result / 2)
      @hero.renown += (@result / 2)
    elsif @hero.gold < 50
      @marked_for_death = true
    else
      @hero.update(gold: @hero.gold - 50, life: @hero.life - 1)
      @marked_for_death = true if @hero.life.zero?
    end
  end

  def bonus
    if @result < 250
      case @quest.element
      when 'fire'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Pilgrim's Staff", quality: Quality.find(7),
                                     type: Type.find(1), enchant: Enchant.find(4), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Pilgrim.png'),
                                 filename: 'Pilgrim.png', content_type: 'image/png')
      when 'ice'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Flame Legion Gladius', quality: Quality.find(7),
                                     type: Type.find(3), enchant: Enchant.find(1), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Gladius.png'),
                                 filename: 'Gladius.png', content_type: 'image/png')
      when 'nature'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Woodsman's Axe", quality: Quality.find(7),
                                     type: Type.find(4), enchant: Enchant.find(10), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Woodaxe.png'),
                                 filename: 'Woodaxe.png', content_type: 'image/png')
      when 'earth'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Military Pick', quality: Quality.find(7),
                                     type: Type.find(2), enchant: Enchant.find(7), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Pick.png'),
                                 filename: 'Pick.png', content_type: 'image/png')
      end
    elsif @result < 300
      case @quest.element
      when 'fire'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Pharaoh's Kopesh", quality: Quality.find(8),
                                     type: Type.find(5), enchant: Enchant.find(8), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Kopesh.png'),
                                 filename: 'Kopesh.png', content_type: 'image/png')
      when 'ice'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Death Knight's Glaive", quality: Quality.find(8),
                                     type: Type.find(8), enchant: Enchant.find(11), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Glaive.png'),
                                 filename: 'Glaive.png', content_type: 'image/png')
      when 'nature'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Goblin King's Pikestaff", quality: Quality.find(8),
                                     type: Type.find(6), enchant: Enchant.find(5), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Goblin.png'),
                                 filename: 'Goblin.png', content_type: 'image/png')
      when 'earth'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Volcanic Cudgel', quality: Quality.find(8),
                                     type: Type.find(7), enchant: Enchant.find(2), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Cudgel.png'),
                                 filename: 'Cudgel.png', content_type: 'image/png')
      end
    else
      case @quest.element
      when 'fire'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Spear of the Scorpion Queen', quality: Quality.find(9),
                                     type: Type.find(14), enchant: Enchant.find(12), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Scorpion.png'),
                                 filename: 'Scorpion.png', content_type: 'image/png')
      when 'ice'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Scepter of Eternal Life', quality: Quality.find(9),
                                     type: Type.find(15), enchant: Enchant.find(9), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Scepter.png'),
                                 filename: 'Scepter.png', content_type: 'image/png')
      when 'nature'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: 'Meteoric Battleaxe', quality: Quality.find(9),
                                     type: Type.find(16), enchant: Enchant.find(3), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Meteoric.png'),
                                 filename: 'Meteoric.png', content_type: 'image/png')
      when 'earth'
        @bonus_loot = Weapon.create!(hero_id: @hero.id, name: "Stone Giant's Blade", quality: Quality.find(9),
                                     type: Type.find(13), enchant: Enchant.find(6), uses: 0)
        @bonus_loot.image.attach(io: File.open('app/assets/images/Giant.png'),
                                 filename: 'Giant.png', content_type: 'image/png')
      end
    end
  end

  def destroy_item
    @equipment.update(item_id: nil)
    @current_item.destroy
  end

  def calc_remaining_uses
    @remaining_uses = 'N/A'
    return if @current_weapon == 'None'

    total_durability = @current_weapon.type.durability + @current_weapon.quality.modifier
    @remaining_uses = total_durability - @current_weapon.uses
  end

  def damage_weapon
    @current_weapon.update(uses: @current_weapon.uses + 1)
    calc_remaining_uses
    return unless @remaining_uses < 1

    @equipment.update(weapon_id: nil)
    @current_weapon.destroy
  end

  def reward
    loot_drop = rand(1..10)
    if loot_drop < 6
      @reward = Item.create(hero_id: @hero.id, level: 1, element: @quest.element)
      case @quest.element
      when 'fire'
        @reward.update(name: 'Spicy Tea')
      when 'ice'
        @reward.update(name: 'Water Melon')
      when 'nature'
        @reward.update(name: 'Magic Bean')
      when 'earth'
        @reward.update(name: 'Stone Fruit')
      end
    elsif loot_drop < 9
      @reward = Item.create(hero_id: @hero.id, level: 2, element: @quest.element)
      case @quest.element
      when 'fire'
        @reward.update(name: 'Potion of Heat')
      when 'ice'
        @reward.update(name: 'Potion of Cold')
      when 'nature'
        @reward.update(name: 'Potion of Strength')
      when 'earth'
        @reward.update(name: 'Potion of Stoneskin')
      end
    else
      @reward = Item.create(hero_id: @hero.id, level: 3, element: @quest.element)
      case @quest.element
      when 'fire'
        @reward.update(name: 'Immolation Scroll')
      when 'ice'
        @reward.update(name: 'Freezing Scroll')
      when 'nature'
        @reward.update(name: 'Growth Scroll')
      when 'earth'
        @reward.update(name: 'Fissure Scroll')
      end
    end
    @reward.image.attach(io: File.open("app/assets/images/#{@reward.element}#{@reward.level}.png"),
                         filename: "#{@reward.element}#{@reward.level}.png", content_type: 'image/png')
    weapon_drop
  end

  def weapon_drop
    weapon_roll = rand(1..5)
    return unless weapon_roll == 5

    @weapon_drop = true

    type_roll = rand(1..6)
    type = if type_roll < 3
             rand(1..4)
           elsif type_roll < 6
             rand(5..12)
           else
             rand(13..18)
           end
    quality_roll = rand(1..20)
    quality = if quality_roll < 3
                1
              elsif quality_roll < 7
                2
              elsif quality_roll < 14
                3
              elsif quality_roll < 18
                4
              elsif quality_roll < 20
                5
              else
                6
              end
    enchant_roll = rand(1..10)
    enchant = if enchant_roll < 5
                nil
              elsif enchant_roll < 8
                Enchant.find_by(bonus: 8, imbue: @quest.element)
              elsif enchant_roll < 10
                Enchant.find_by(bonus: 14, imbue: @quest.element)
              else
                Enchant.find_by(bonus: 20, imbue: @quest.element)
              end
    @new_weapon = Weapon.create(hero_id: @hero.id, type: Type.find_by(id: type), quality: Quality.find_by(id: quality),
                                enchant: Enchant.find_by(id: enchant), uses: 0)
    if @new_weapon.enchant.nil?
      @new_weapon.update(name: "#{@new_weapon.quality.name} #{@new_weapon.type.name}")
    else
      @new_weapon.update(name: "#{@new_weapon.quality.name} #{@new_weapon.type.name} of #{@new_weapon.enchant.name}")
    end
    @new_weapon.image.attach(io: File.open("app/assets/images/#{@new_weapon.type.name}.png"),
                             filename: "#{@new_weapon.type.name}.png", content_type: 'image/png')
  end
end
