# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

Type.destroy_all
Quality.destroy_all
Enchant.destroy_all
Item.destroy_all
Quest.destroy_all

## TYPES ##
### TIER ONE ###
staff = Type.create!(name: 'Staff', damage: 23, durability: 6)
hatchet = Type.create!(name: 'Hatchet', damage: 21, durability: 9)
falchion = Type.create!(name: 'Falchion', damage: 23, durability: 7)
greataxe = Type.create!(name: 'Greataxe', damage: 25, durability: 7)
### TIER TWO ###
sword = Type.create!(name: 'Sword', damage: 30, durability: 9)
spear = Type.create!(name: 'Spear', damage: 43, durability: 10)
mace = Type.create!(name: 'Mace', damage: 34, durability: 14)
halberd = Type.create!(name: 'Halberd', damage: 51, durability: 13)
hammer = Type.create!(name: 'Warhammer', damage: 60, durability: 15)
bardiche = Type.create!(name: 'Bardiche', damage: 64, durability: 13)
greatsword = Type.create!(name: 'Greatsword', damage: 64, durability: 12)
handaxe = Type.create!(name: 'Hand-Axe', damage: 28, durability: 11)
### TIER THREE ###
twohander = Type.create!(name: 'Zweihander', damage: 66, durability: 14)
pike = Type.create!(name: 'Pike', damage: 56, durability: 11)
morningstar = Type.create!(name: 'Morningstar', damage: 77, durability: 16)
battleaxe = Type.create!(name: 'Battle-Axe', damage: 82, durability: 14)
club = Type.create!(name: 'War-Club', damage: 44, durability: 15)
cleaver = Type.create!(name: 'War-Axe', damage: 37, durability: 12)

## QUALITIES ##
old = Quality.create!(name: 'Old', modifier: -5)             # 10% (1-2)
weak = Quality.create!(name: 'Weak', modifier: -3)           # 20% (3-6)
plain = Quality.create!(name: 'Plain', modifier: 0)          # 35% (7-13)
fine = Quality.create!(name: 'Fine', modifier: 2)            # 20% (14-17)
strong = Quality.create!(name: 'Strong', modifier: 5)        # 10% (18-19)
master = Quality.create!(name: 'Masterwork', modifier: 10)   # 5%  (20)
# Uniques #
rare = Quality.create!(name: 'Rare', modifier: 6)
epic = Quality.create!(name: 'Epic', modifier: 9)
legendary = Quality.create!(name: 'Legendary', modifier: 12)

## ENCHANTS ##
fire1 = Enchant.create!(name: 'Lesser Burning', bonus: 8, imbue: 'fire')         # 12 vs Tundra / 4 vs Desert
fire2 = Enchant.create!(name: 'Burning', bonus: 14, imbue: 'fire')               # 21 vs Tundra / 7 vs Desert
fire3 = Enchant.create!(name: 'Greater Burning', bonus: 20, imbue: 'fire')       # 30 vs Tundra / 10 vs Desert

ice1 = Enchant.create!(name: 'Lesser Slowing', bonus: 8, imbue: 'ice')           # 12 vs Desert / 4 vs Tundra
ice2 = Enchant.create!(name: 'Slowing', bonus: 14, imbue: 'ice')                 # 21 vs Desert / 7 vs Tundra
ice3 = Enchant.create!(name: 'Greater Slowing', bonus: 20, imbue: 'ice')         # 30 vs Desert / 10 vs Tundra

nature1 = Enchant.create!(name: 'Lesser Lifesteal', bonus: 8, imbue: 'nature')   # 12 vs Mountain / 4 vs Forest
nature2 = Enchant.create!(name: 'Lifesteal', bonus: 14, imbue: 'nature')         # 21 vs Mountain / 7 vs Forest
nature3 = Enchant.create!(name: 'Greater Lifesteal', bonus: 20, imbue: 'nature') # 30 vs Mountain / 10 vs Forest

earth1 = Enchant.create!(name: 'Lesser Agony', bonus: 8, imbue: 'earth')         # 12 vs Forest / 4 vs Mountain
earth2 = Enchant.create!(name: 'Agony', bonus: 14, imbue: 'earth')               # 21 vs Forest / 7 vs Mountain
earth3 = Enchant.create!(name: 'Greater Agony', bonus: 20, imbue: 'earth')       # 30 vs Forest / 10 vs Mountain

## WEAPONS ##
# Placeholders #
pilgrim = Weapon.create!(name: "Pilgrim's Staff", quality: rare, type: staff, enchant: ice1, uses: 0, price: 175)
pilgrim.image.attach(io: File.open('app/assets/images/Pilgrim.png'),
                     filename: 'Pilgrim.png', content_type: 'image/png')

owclb = Weapon.create!(name: 'Old War-Club of Burning', quality: old, type: club, enchant: fire2, uses: 0,
                       price: 292)
owclb.image.attach(io: File.open('app/assets/images/War-Club.png'),
                   filename: 'War-Club.png', content_type: 'image/png')

gladius = Weapon.create!(name: 'Flame Legion Gladius', quality: rare, type: falchion, enchant: fire1, uses: 0,
                         price: 193)
gladius.image.attach(io: File.open('app/assets/images/Gladius.png'),
                     filename: 'Gladius.png', content_type: 'image/png')

sws = Weapon.create!(name: 'Strong Warhammer of Slowing', quality: strong, type: hammer, enchant: ice2, uses: 0,
                     price: 790)
sws.image.attach(io: File.open('app/assets/images/Warhammer.png'),
                 filename: 'Warhammer.png', content_type: 'image/png')

fbl = Weapon.create!(name: 'Fine Bardiche of Lifesteal', quality: fine, type: bardiche, enchant: nature2, uses: 0,
                     price: 600)
fbl.image.attach(io: File.open('app/assets/images/Bardiche.png'),
                 filename: 'Bardiche.png', content_type: 'image/png')

woodaxe = Weapon.create!(name: "Woodsman's Axe", quality: rare, type: greataxe, enchant: earth1, uses: 0, price: 204)
woodaxe.image.attach(io: File.open('app/assets/images/Woodaxe.png'),
                     filename: 'Woodaxe.png', content_type: 'image/png')

cwa = Weapon.create!(name: 'Weak War-Axe', quality: weak, type: cleaver, uses: 0, price: 153)
cwa.image.attach(io: File.open('app/assets/images/War-Axe.png'),
                 filename: 'War-Axe.png', content_type: 'image/png')

fg = Weapon.create!(name: 'Masterwork Greatsword', quality: master, type: greatsword, uses: 0, price: 814)
fg.image.attach(io: File.open('app/assets/images/Greatsword.png'),
                filename: 'Greatsword.png', content_type: 'image/png')

haa = Weapon.create!(name: 'Hand-Axe of Agony', quality: plain, type: handaxe, enchant: earth2, uses: 0, price: 231)
haa.image.attach(io: File.open('app/assets/images/Hand-Axe.png'),
                 filename: 'Hand-Axe.png', content_type: 'image/png')

pick = Weapon.create!(name: 'Military Pick', quality: rare, type: hatchet, enchant: nature1, uses: 0, price: 215)
pick.image.attach(io: File.open('app/assets/images/Pick.png'),
                  filename: 'Pick.png', content_type: 'image/png')

6.times do
  x = Weapon.create!(quality: Quality.find(rand(2..4)), type: Type.find(rand(1..18)),
                     enchant: Enchant.find(rand(1..12)), uses: 0)
  x.update(name: "#{x.quality.name} #{x.type.name} of #{x.enchant.name}")
  x.update(price: ((x.type.damage + x.quality.modifier) * (x.type.durability + x.quality.modifier) +
           (x.enchant.bonus * (x.type.durability + x.quality.modifier)) / 2))
  x.image.attach(io: File.open("app/assets/images/#{x.type.name}.png"),
                 filename: "#{x.type.name}.png", content_type: 'image/png')
end

4.times do
  x = Weapon.create!(quality: Quality.find(rand(2..4)), type: Type.find(rand(1..18)),
                     uses: 0)
  x.update(name: "#{x.quality.name} #{x.type.name}")
  x.update(price: ((x.type.damage + x.quality.modifier) * (x.type.durability + x.quality.modifier) / 2))
  x.image.attach(io: File.open("app/assets/images/#{x.type.name}.png"),
                 filename: "#{x.type.name}.png", content_type: 'image/png')
end

3.times do
  x = Weapon.create!(quality: Quality.find(4..5), type: Type.find(rand(13..18)),
                     enchant: Enchant.find(rand(1..12)), uses: 0)
  x.update(name: "#{x.quality.name} #{x.type.name}")
  x.update(price: ((x.type.damage + x.quality.modifier) * (x.type.durability + x.quality.modifier) +
           (x.enchant.bonus * (x.type.durability + x.quality.modifier)) / 2))
  x.image.attach(io: File.open("app/assets/images/#{x.type.name}.png"),
                 filename: "#{x.type.name}.png", content_type: 'image/png')
end

x = Weapon.create!(quality: Quality.find(6), type: Type.find(rand(5..12)),
                   uses: 0)
x.update(name: "#{x.quality.name} #{x.type.name}")
x.update(price: ((x.type.damage + x.quality.modifier) * (x.type.durability + x.quality.modifier) / 2))
x.image.attach(io: File.open("app/assets/images/#{x.type.name}.png"),
               filename: "#{x.type.name}.png", content_type: 'image/png')

## Uniques ##
# # Desert #
# Weapon.create!(name: "Pilgrim's Staff", quality: rare, type: staff, enchant: ice1, uses: 0)
# Weapon.create!(name: "Pharaoh's Kopesh", quality: epic, type: sword, enchant: nature2, uses: 0)
# Weapon.create!(name: 'Spear of the Scorpion Queen', quality: legendary, type: pike, enchant: earth3, uses: 0)
# # Tundra #
# Weapon.create!(name: 'Flame Legion Gladius', quality: rare, type: falchion, enchant: fire1, uses: 0)
# Weapon.create!(name: "Death Knight's Glaive", quality: epic, type: halberd, enchant: earth2, uses: 0)
# Weapon.create!(name: 'Scepter of Eternal Life', quality: legendary, type: morningstar, enchant: nature3, uses: 0)
# # Forest #
# Weapon.create!(name: "Woodsman's Axe", quality: rare, type: greataxe, enchant: earth1, uses: 0)
# Weapon.create!(name: "Goblin King's Pikestaff", quality: epic, type: spear, enchant: ice2, uses: 0)
# Weapon.create!(name: 'Meteoric Battleaxe', quality: legendary, type: battleaxe, enchant: fire3, uses: 0)
# # Mountain #
# Weapon.create!(name: 'Military Pick', quality: rare, type: hatchet, enchant: nature1, uses: 0)
# Weapon.create!(name: 'Volcanic Cudgel', quality: epic, type: mace, enchant: fire2, uses: 0)
# Weapon.create!(name: "Stone Giant's Blade", quality: legendary, type: twohander, enchant: ice3, uses: 0)

## ITEMS ##
# Desert #
tea = Item.create!(name: 'Spicy Tea', level: 1, element: 'fire', price: 21)
tea.image.attach(io: File.open("app/assets/images/#{tea.element}#{tea.level}.png"),
                 filename: "#{tea.element}#{tea.level}.png", content_type: 'image/png')

heat_pot = Item.create!(name: 'Potion of Heat', level: 2, element: 'fire', price: 30)
heat_pot.image.attach(io: File.open("app/assets/images/#{heat_pot.element}#{heat_pot.level}.png"),
                      filename: "#{heat_pot.element}#{heat_pot.level}.png", content_type: 'image/png')

immolation = Item.create!(name: 'Immolation Scroll', level: 3, element: 'fire', price: 45)
immolation.image.attach(io: File.open("app/assets/images/#{immolation.element}#{immolation.level}.png"),
                        filename: "#{immolation.element}#{immolation.level}.png", content_type: 'image/png')

# Tundra #
melon = Item.create!(name: 'Water Melon', level: 1, element: 'ice', price: 21)
melon.image.attach(io: File.open("app/assets/images/#{melon.element}#{melon.level}.png"),
                   filename: "#{melon.element}#{melon.level}.png", content_type: 'image/png')

cold_pot = Item.create!(name: 'Potion of Cold', level: 2, element: 'ice', price: 30)
cold_pot.image.attach(io: File.open("app/assets/images/#{cold_pot.element}#{cold_pot.level}.png"),
                      filename: "#{cold_pot.element}#{cold_pot.level}.png", content_type: 'image/png')

freezing = Item.create!(name: 'Freezing Scroll', level: 3, element: 'ice', price: 45)
freezing.image.attach(io: File.open("app/assets/images/#{freezing.element}#{freezing.level}.png"),
                      filename: "#{freezing.element}#{freezing.level}.png", content_type: 'image/png')

# Forest #
beans = Item.create!(name: 'Magic Bean', level: 1, element: 'nature', price: 21)
beans.image.attach(io: File.open("app/assets/images/#{beans.element}#{beans.level}.png"),
                   filename: "#{beans.element}#{beans.level}.png", content_type: 'image/png')

strength_pot = Item.create!(name: 'Potion of Strength', level: 2, element: 'nature', price: 30)
strength_pot.image.attach(io: File.open("app/assets/images/#{strength_pot.element}#{strength_pot.level}.png"),
                          filename: "#{strength_pot.element}#{strength_pot.level}.png", content_type: 'image/png')

growth = Item.create!(name: 'Growth Scroll', level: 3, element: 'nature', price: 45)
growth.image.attach(io: File.open("app/assets/images/#{growth.element}#{growth.level}.png"),
                    filename: "#{growth.element}#{growth.level}.png", content_type: 'image/png')

# Mountains #
fruit = Item.create!(name: 'Stone Fruit', level: 1, element: 'earth', price: 21)
fruit.image.attach(io: File.open("app/assets/images/#{fruit.element}#{fruit.level}.png"),
                   filename: "#{fruit.element}#{fruit.level}.png", content_type: 'image/png')

stone_pot = Item.create!(name: 'Potion of Stoneskin', level: 2, element: 'earth', price: 30)
stone_pot.image.attach(io: File.open("app/assets/images/#{stone_pot.element}#{stone_pot.level}.png"),
                       filename: "#{stone_pot.element}#{stone_pot.level}.png", content_type: 'image/png')

fissure = Item.create!(name: 'Fissure Scroll', level: 3, element: 'earth', price: 45)
fissure.image.attach(io: File.open("app/assets/images/#{fissure.element}#{fissure.level}.png"),
                     filename: "#{fissure.element}#{fissure.level}.png", content_type: 'image/png')

## QUESTS ##
Quest.create!(title: 'Explore ancient tombs in the desert',
              description: 'These hot, sandy dunes are dotted with ancient tombs protected by fearless mummies and anubites. Giant scorpions roam the sands and phoenixes patrol the sky. The tombs are full of golden relics and treasure of course, but the journey to them is harsh and unforgiving. The enemies here are vulnerable to slow and resistant to the effects of burning and lifesteal enchantments.',
              element: 'fire',
              resistance: 'nature',
              weakness: 'ice')

Quest.create!(title: 'Loot the ruined cities of the tundra',
              description: 'The frozen lands are crawling with hordes of undead led by powerful necromancers. Zombies, skeletons and ghouls are all that remain of the old Empire. The great ruined cities of the imperium still hold much of their old wealth for those that can beat the cold and the walking dead. The enemies here are vulnerable to burning and resistant to the effects of slow and agony enchantments.',
              element: 'ice',
              resistance: 'earth',
              weakness: 'fire')

Quest.create!(title: 'Hunt great beasts within the dark forest',
              description: 'The dark forest is home to many orcish and goblin tribes as well as savage beasts of all kinds, made massive and enraged by old witchcraft. Many within the new kingdom will pay a handsome fee for the meat and furs of the local animals, partly because they are so difficult to hunt. The enemies here are vulnerable to agony and resistant to the effects of lifesteal and slow enchantments.',
              element: 'nature',
              resistance: 'ice',
              weakness: 'earth')

Quest.create!(title: 'Mine for riches atop the mountains',
              description: 'The high peaks of the mountain ranges are inhospitible to most, but the cave trolls and griffons that reside there are savagely territorial. These scarcely visited places are rich with rare minerals, ores and precious gemstones, untapped due to the dangers of accessing them. The enemies here are vulnerable to lifesteal and resistant to the effects of agony and burning enchantments.',
              element: 'earth',
              resistance: 'fire',
              weakness: 'nature')

p "#{Type.count}/18 Types created successfully"
p "#{Quality.count}/9 Qualities created successfully"
p "#{Enchant.count}/12 Enchants created successfully"
p "#{Weapon.count}/24 Weapons created successfully"
p "#{Item.count}/12 Items created successfully"
p "#{Quest.count}/4 Quests created successfully"
