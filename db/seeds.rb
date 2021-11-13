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
warhammer = Type.create(name: 'Warhammer', damage: 60, durability: 15)
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

ice1 = Enchant.create(name: 'Lesser Slow', bonus: 6, imbue: 'ice')              # 9 vs Desert / 3 vs Tundra
ice2 = Enchant.create(name: 'Slow', bonus: 10, imbue: 'ice')                    # 15 vs Desert / 5 vs Tundra
ice3 = Enchant.create(name: 'Greater Slow', bonus: 16, imbue: 'ice')            # 24 vs Desert / 8 vs Tundra

nature1 = Enchant.create(name: 'Lesser Lifesteal', bonus: 6, imbue: 'nature')   # 9 vs Mountain / 3 vs Forest
nature2 = Enchant.create(name: 'Lifesteal', bonus: 10, imbue: 'nature')         # 15 vs Mountain / 5 vs Forest
nature3 = Enchant.create(name: 'Greater Lifesteal', bonus: 16, imbue: 'nature') # 24 vs Mountain / 8 vs Forest

earth1 = Enchant.create(name: 'Lesser Agony', bonus: 6, imbue: 'earth')         # 9 vs Forest / 3 vs Mountain
earth2 = Enchant.create(name: 'Agony', bonus: 10, imbue: 'earth')               # 15 vs Forest / 5 vs Mountain
earth3 = Enchant.create(name: 'Greater Agony', bonus: 16, imbue: 'earth')       # 24 vs Forest / 8 vs Mountain

## WEAPONS ##
# Desert #
pilgrim = Weapon.create(name: "Pilgrim's Staff", quality: fine, type: staff, enchant: ice1, uses: 0)
kopesh = Weapon.create(name: "Pharaoh's Kopesh", quality: strong, type: sword, enchant: nature2, uses: 0)
sk_spear = Weapon.create(name: 'Spear of the Scorpion Queen', quality: master, type: pike, enchant: earth3, uses: 0)
# Tundra #
gladius = Weapon.create(name: 'Flame Legion Gladius', quality: fine, type: falchion, enchant: fire1, uses: 0)
doom_halberd = Weapon.create(name: "Death Knight's Guisarme", quality: strong, type: halberd, enchant: earth2, uses: 0)
scepter = Weapon.create(name: 'Scepter of Eternal Life', quality: master, type: morningstar, enchant: nature3, uses: 0)
# Forest #
wood_axe = Weapon.create(name: "Woodsman's Axe", quality: fine, type: greataxe, enchant: earth1, uses: 0)
gg_spear = Weapon.create(name: "Goblin King's Pikestaff", quality: strong, type: spear, enchant: ice2, uses: 0)
warlord_axe = Weapon.create(name: 'Armageddon Battleaxe', quality: master, type: battleaxe, enchant: fire3, uses: 0)
# Mountain #
stone_pick = Weapon.create(name: 'Military Pick', quality: fine, type: hatchet, enchant: nature1, uses: 0)
volcanic = Weapon.create(name: 'Volcanic Cudgel', quality: strong, type: mace, enchant: fire2, uses: 0)
giant_blade = Weapon.create(name: "Stone Giant's Blade", quality: master, type: twohander, enchant: ice3, uses: 0)

## Items ##
# Desert #
tea = Item.create(name: "Spicy Tea", level: 1, element: "fire")
heat_pot = Item.create(name: "Potion of Heat", level: 2, element: "fire")
immolation = Item.create(name: "Immolation Scroll", level: 3, element: "fire")
# Tundra #
melon = Item.create(name: "Water Melon", level: 1, element: "ice")
cold_pot = Item.create(name: "Potion of Cold", level: 2, element: "ice")
freezing = Item.create(name: "Freezing Scroll", level: 3, element: "ice")
# Forest #
beans = Item.create(name: "Magic Beans", level: 1, element: "nature")
strength_pot = Item.create(name: "Potion of Strength", level: 2, element: "nature")
growth = Item.create(name: "Growth Scroll", level: 3, element: "nature")
# Mountain #
fruit = Item.create(name: "Stone Fruit", level: 1, element: "earth")
stone_pot = Item.create(name: "Potion of Stoneskin", level: 2, element: "earth")
fissure = Item.create(name: "Fissure Scroll", level: 3, element: "earth")
