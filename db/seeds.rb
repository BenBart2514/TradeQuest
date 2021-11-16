# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Type.destroy_all
Quality.destroy_all
Enchant.destroy_all
Item.destroy_all
Quest.destroy_all

## TYPES ##
### TIER ONE ###
staff = Type.create(name: 'Staff', damage: 23, durability: 6)
hatchet = Type.create(name: 'Hatchet', damage: 21, durability: 9)
falchion = Type.create(name: 'Falchion', damage: 23, durability: 7)
greataxe = Type.create(name: 'Greataxe', damage: 25, durability: 7)
### TIER TWO ###
sword = Type.create(name: 'Sword', damage: 30, durability: 9)
spear = Type.create(name: 'Spear', damage: 43, durability: 10)
mace = Type.create(name: 'Mace', damage: 34, durability: 14)
halberd = Type.create(name: 'Halberd', damage: 51, durability: 13)
hammer = Type.create(name: 'Warhammer', damage: 60, durability: 15)
bardiche = Type.create(name: 'Bardiche', damage: 64, durability: 13)
greatsword = Type.create(name: 'Greatsword', damage: 64, durability: 12)
handaxe = Type.create(name: 'Hand Axe', damage: 28, durability: 11)
### TIER THREE ###
twohander = Type.create(name: 'Zweihander', damage: 66, durability: 14)
pike = Type.create(name: 'Pike', damage: 56, durability: 11)
morningstar = Type.create(name: 'Morningstar', damage: 77, durability: 16)
battleaxe = Type.create(name: 'Battle Axe', damage: 82, durability: 14)
club = Type.create(name: 'War Club', damage: 44, durability: 15)
cleaver = Type.create(name: 'Cleaver', damage: 37, durability: 12)

## QUALITIES ##
old = Quality.create(name: 'Old', modifier: -5)             # 10% (1-2)
cheap = Quality.create(name: 'Cheap', modifier: -3)         # 20% (3-6)
plain = Quality.create(name: 'Plain', modifier: 0)          # 35% (7-13)
fine = Quality.create(name: 'Fine', modifier: 2)            # 20% (14-17)
strong = Quality.create(name: 'Strong', modifier: 5)        # 10% (18-19)
master = Quality.create(name: 'Masterwork', modifier: 10)   # 5%  (20)

## ENCHANTS ##
fire1 = Enchant.create(name: 'Lesser Burning', bonus: 6, imbue: 'fire')         # 9 vs Tundra / 3 vs Desert
fire2 = Enchant.create(name: 'Burning', bonus: 10, imbue: 'fire')               # 15 vs Tundra / 5 vs Desert
fire3 = Enchant.create(name: 'Greater Burning', bonus: 16, imbue: 'fire')       # 24 vs Tundra / 8 vs Desert

ice1 = Enchant.create(name: 'Lesser Slowing', bonus: 6, imbue: 'ice')              # 9 vs Desert / 3 vs Tundra
ice2 = Enchant.create(name: 'Slowing', bonus: 10, imbue: 'ice')                    # 15 vs Desert / 5 vs Tundra
ice3 = Enchant.create(name: 'Greater Slowing', bonus: 16, imbue: 'ice')            # 24 vs Desert / 8 vs Tundra

nature1 = Enchant.create(name: 'Lesser Lifesteal', bonus: 6, imbue: 'nature')   # 9 vs Mountain / 3 vs Forest
nature2 = Enchant.create(name: 'Lifesteal', bonus: 10, imbue: 'nature')         # 15 vs Mountain / 5 vs Forest
nature3 = Enchant.create(name: 'Greater Lifesteal', bonus: 16, imbue: 'nature') # 24 vs Mountain / 8 vs Forest

earth1 = Enchant.create(name: 'Lesser Agony', bonus: 6, imbue: 'earth')         # 9 vs Forest / 3 vs Mountain
earth2 = Enchant.create(name: 'Agony', bonus: 10, imbue: 'earth')               # 15 vs Forest / 5 vs Mountain
earth3 = Enchant.create(name: 'Greater Agony', bonus: 16, imbue: 'earth')       # 24 vs Forest / 8 vs Mountain

## WEAPONS ##
# Placeholders #
Weapon.create(name: "Pilgrim's Staff", quality: fine, type: staff, enchant: ice1, uses: 0, price: 237)
Weapon.create(name: 'Old War Club of Lesser Burning', quality: old, type: club, enchant: fire1, uses: 0, price: 360)
Weapon.create(name: 'Flame Legion Gladius', quality: fine, type: falchion, enchant: fire1, uses: 0, price: 265)
Weapon.create(name: 'Strong Warhammer of Slowing', quality: strong, type: hammer, enchant: ice2, uses: 0, price: 1500)
Weapon.create(name: 'Fine Bardiche of Lifesteal', quality: fine, type: bardiche, enchant: nature2, uses: 0, price: 1118)
Weapon.create(name: "Woodsman's Axe", quality: fine, type: greataxe, enchant: earth1, uses: 0, price: 282)
Weapon.create(name: 'Cheap Cleaver', quality: cheap, type: cleaver, uses: 0, price: 310)
Weapon.create(name: 'Fine Greatsword', quality: fine, type: greatsword, uses: 0, price: 921)
Weapon.create(name: 'Hand Axe of Agony', quality: plain, type: handaxe, enchant: earth2, uses: 0, price: 408)
Weapon.create(name: 'Military Pick', quality: fine, type: hatchet, enchant: nature1, uses: 0, price: 298)
# Desert #
Weapon.create(name: "Pilgrim's Staff", quality: fine, type: staff, enchant: ice1, uses: 0, price: 253)
Weapon.create(name: "Pharaoh's Kopesh", quality: strong, type: sword, enchant: nature2, uses: 0, price: 565)
Weapon.create(name: 'Spear of the Scorpion Queen', quality: master, type: pike, enchant: earth3, uses: 0)
# Tundra #
Weapon.create(name: 'Flame Legion Gladius', quality: fine, type: falchion, enchant: fire1, uses: 0, price: 277)
Weapon.create(name: "Death Knight's Guisarme", quality: strong, type: halberd, enchant: earth2, uses: 0, price: 1159)
Weapon.create(name: 'Scepter of Eternal Life', quality: master, type: morningstar, enchant: nature3, uses: 0)
# Forest #
Weapon.create(name: "Woodsman's Axe", quality: fine, type: greataxe, enchant: earth1, uses: 0, price: 292)
Weapon.create(name: "Goblin King's Pikestaff", quality: strong, type: spear, enchant: ice2, uses: 0, price: 805)
Weapon.create(name: 'Armageddon Battleaxe', quality: master, type: battleaxe, enchant: fire3, uses: 0)
# Mountain #
Weapon.create(name: 'Military Pick', quality: fine, type: hatchet, enchant: nature1, uses: 0, price: 316)
Weapon.create(name: 'Volcanic Cudgel', quality: strong, type: mace, enchant: fire2, uses: 0, price: 864)
Weapon.create(name: "Stone Giant's Blade", quality: master, type: twohander, enchant: ice3, uses: 0)

## ITEMS ##
# Desert #
Item.create(name: 'Spicy Tea', level: 1, element: 'fire', price: 10)
Item.create(name: 'Spicy Tea', level: 1, element: 'fire', price: 10)
Item.create(name: 'Spicy Tea', level: 1, element: 'fire', price: 10)
Item.create(name: 'Spicy Tea', level: 1, element: 'fire', price: 10)
Item.create(name: 'Spicy Tea', level: 1, element: 'fire', price: 10)
Item.create(name: 'Potion of Heat', level: 2, element: 'fire', price: 20)
Item.create(name: 'Potion of Heat', level: 2, element: 'fire', price: 20)
Item.create(name: 'Immolation Scroll', level: 3, element: 'fire', price: 45)
# Tundra #
Item.create(name: 'Water Melon', level: 1, element: 'ice', price: 10)
Item.create(name: 'Water Melon', level: 1, element: 'ice', price: 10)
Item.create(name: 'Water Melon', level: 1, element: 'ice', price: 10)
Item.create(name: 'Water Melon', level: 1, element: 'ice', price: 10)
Item.create(name: 'Water Melon', level: 1, element: 'ice', price: 10)
Item.create(name: 'Potion of Cold', level: 2, element: 'ice', price: 20)
Item.create(name: 'Potion of Cold', level: 2, element: 'ice', price: 20)
Item.create(name: 'Freezing Scroll', level: 3, element: 'ice', price: 45)
# Forest #
Item.create(name: 'Magic Beans', level: 1, element: 'nature', price: 10)
Item.create(name: 'Magic Beans', level: 1, element: 'nature', price: 10)
Item.create(name: 'Magic Beans', level: 1, element: 'nature', price: 10)
Item.create(name: 'Magic Beans', level: 1, element: 'nature', price: 10)
Item.create(name: 'Magic Beans', level: 1, element: 'nature', price: 10)
Item.create(name: 'Potion of Strength', level: 2, element: 'nature', price: 20)
Item.create(name: 'Potion of Strength', level: 2, element: 'nature', price: 20)
Item.create(name: 'Growth Scroll', level: 3, element: 'nature', price: 45)
# Mountains #
Item.create(name: 'Stone Fruit', level: 1, element: 'earth', price: 10)
Item.create(name: 'Stone Fruit', level: 1, element: 'earth', price: 10)
Item.create(name: 'Stone Fruit', level: 1, element: 'earth', price: 10)
Item.create(name: 'Stone Fruit', level: 1, element: 'earth', price: 10)
Item.create(name: 'Stone Fruit', level: 1, element: 'earth', price: 10)
Item.create(name: 'Potion of Stoneskin', level: 2, element: 'earth', price: 20)
Item.create(name: 'Potion of Stoneskin', level: 2, element: 'earth', price: 20)
Item.create(name: 'Fissure Scroll', level: 3, element: 'earth', price: 45)

## QUESTS ##
Quest.create(title: 'Explore ancient tombs in the desert',
             description: 'These hot, sandy dunes are dotted with ancient tombs protected by fearless mummies and anubites. Giant scorpions roam the sands and phoenixes patrol the sky. The tombs are full of golden relics and treasure of course, but the journey to them is harsh and unforgiving. The enemies here are vulnerable to slow and resistant to the effects of burning and lifesteal enchantments.',
             element: 'fire',
             resistance: 'nature',
             weakness: 'ice')

Quest.create(title: 'Loot the ruined cities of the tundra',
             description: 'The frozen lands are crawling with hordes of undead. Zombies, skeletons and ghouls are all that remain of the old Empire. The great ruined cities of the imperium still hold much of their old wealth for those that can beat the cold and the walking dead. The enemies here are vulnerable to burning and resistant to the effects of slow and agony enchantments.',
             element: 'ice',
             resistance: 'earth',
             weakness: 'fire')

Quest.create(title: 'Hunt great beasts within the dark forest',
             description: 'The Dark forest is home to many orcish and goblin tribes as well as savage beasts of all kinds, made massive and enraged by a dark taint. Many in the kingdom will pay handsomely for the meat and furs of the local animals, partly because they are so difficult to hunt. The enemies here are vulnerable to agony and resistant to the effects of lifesteal and slow enchantments.',
             element: 'nature',
             resistance: 'ice',
             weakness: 'earth')

Quest.create(title: 'Mine for riches atop the mountains',
             description: 'The high peaks of the mountain ranges are inhospitible to all but the cave trolls and griffons that reside there. These scarcely visited places are rich with rare minerals, ores and precious gemstones, untapped due to the dangers of accessing them. The enemies here are vulnerable to lifesteal and resistant to the effects of agony and burning enchantments.',
             element: 'earth',
             resistance: 'fire',
             weakness: 'nature')

p "#{Type.count}/18 Types created successfully"
p "#{Quality.count}/6 Qualities created successfully"
p "#{Enchant.count}/12 Enchants created successfully"
p "#{Weapon.count}/22 Weapons created successfully"
p "#{Item.count}/32 Items created successfully"
p "#{Quest.count}/4 Quests created successfully"
