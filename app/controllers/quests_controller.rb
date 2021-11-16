class QuestsController < ApplicationController
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
    @success = nil
    success_roll
    fate_roll
    gr_change
    reward if @success == true
    destroy_item unless @current_item == 'None'
    damage_weapon unless @current_weapon == 'None'
    @hero.update(quest_id: rand(1..4))
    if @marked_for_death == true
      @equipment.update(weapon_id: nil, item_id: nil)
      @equipment.destroy
      @hero.destroy
      redirect_to questing_path, notice: 'You died... but the gods offer you another chance to live a new life.'
    elsif @success == true
      redirect_to questing_path, notice: 'Quest Successful! -'
      flash[:alert] = "- #{@reward.name} was added to your inventory.You've also earned #{@result} Gold and Renown."
    else
      redirect_to questing_path, notice: 'Quest Failed! -'
      flash[:alert] = "- #{@hero.name} lost 50 Gold 1 Life point."
    end
  end

  def skip
    if @hero.gold < 25
      # display error
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
    @weapon_rating = 0
    @item_rating = 0
    unless @current_weapon == 'None'
      @base_bonus = @current_weapon.type.damage + @current_weapon.quality.modifier
      @enchant_bonus = if @current_weapon.enchant.nil?
                         0
                       elsif @current_weapon.enchant.imbue == @quest.element || @quest.resistance
                         @current_weapon.enchant.bonus / 2
                       elsif @current_weapon.enchant.imbue == @quest.weakness
                         @current_weapon.enchant.bonus * 1.5
                       else
                         @current_weapon.enchant.bonus
                       end
      @enchant_bonus = @enchant_bonus.to_i
      @weapon_rating = @base_bonus + @enchant_bonus
    end
    unless @current_item == 'None'
      if @current_item.level == 1 && @current_item.element == @quest.weakness
        @item_rating = 20
      elsif @current_item.level == 2
        @item_rating = if @current_item.element == @quest.weakness
                         30
                       elsif @current_item.element == @quest.element
                         5
                       elsif @current_item.element == @quest.resistance
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
      @hero.gold += @result
      @hero.renown += @result
    elsif @hero.gold < 50
      @marked_for_death = true
    else
      @hero.update(gold: @hero.gold - 50, life: @hero.life - 1)
      @marked_for_death = true if @hero.life.zero?
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
    if loot_drop < 5
      @reward = Item.create(hero_id: @hero.id, level: 1, element: @quest.element)
      case @quest.element
      when 'fire'
        @reward.update(name: 'Spicy Tea')
      when 'ice'
        @reward.update(name: 'Water Melon')
      when 'nature'
        @reward.update(name: 'Magic Beans')
      when 'earth'
        @reward.update(name: 'Stone Fruit')
      end
    elsif loot_drop < 8
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
    elsif loot_drop < 10
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
    else
      weapon_drop
    end
  end

  def weapon_drop
    type_roll = rand(1..6)
    type = if type_roll < 4
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
                Enchant.find_by(bonus: 6, imbue: @quest.element)
              elsif enchant_roll < 10
                Enchant.find_by(bonus: 10, imbue: @quest.element)
              else
                Enchant.find_by(bonus: 16, imbue: @quest.element)
              end
    @reward = Weapon.create(hero_id: @hero.id, type_id: type, quality_id: quality, enchant_id: enchant, uses: 0)
    if @reward.enchant.nil?
      @reward.update(name: "#{@reward.quality.name} #{@reward.type.name}")
    else
      @reward.update(name: "#{@reward.quality.name} #{@reward.type.name} of #{@reward.enchant.name}")
    end
  end
end
