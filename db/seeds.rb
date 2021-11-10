# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Type.destroy_all
Quality.destroy_all
Enchant.destroy_all
Weapon.destroy_all

## TYPES ##
### TIER ONE ###
staff = WeaponType.create(name: 'Staff', damage: 23, durability: 6)
hatchet = WeaponType.create(name: 'Hatchet', damage: 21, durability: 9)
falchion = WeaponType.create(name: 'Falchion', damage: 23, durability: 7)
greataxe = WeaponType.create(name: 'Greataxe', damage: 25, durability: 7)
### TIER TWO ###
sword = WeaponType.create(name: 'Sword', damage: 30, durability: 9)
spear = WeaponType.create(name: 'Spear', damage: 43, durability: 10)
mace = WeaponType.create(name: 'Mace', damage: 34, durability: 14)
halberd = WeaponType.create(name: 'Halberd', damage: 51, durability: 13)
warhammer = WeaponType.create(name: 'Warhammer', damage: 60, durability: 15)
bardiche = WeaponType.create(name: 'Bardiche', damage: 64, durability: 13)
greatsword = WeaponType.create(name: 'Greatsword', damage: 64, durability: 12)
handaxe = WeaponType.create(name: 'Hand Axe', damage: 28, durability: 11)
### TIER THREE ###
twohander = WeaponType.create(name: 'Zweihander', damage: 66, durability: 14)
pike = WeaponType.create(name: 'Pike', damage: 56, durability: 11)
morningstar = WeaponType.create(name: 'Morningstar', damage: 77, durability: 16)
battleaxe = WeaponType.create(name: 'Battle Axe', damage: 82, durability: 14)
club = WeaponType.create(name: 'War Club', damage: 44, durability: 15)
cleaver = WeaponType.create(name: 'Cleaver', damage: 37, durability: 12)

## QUALITIES ##
old = Quality.create(name: 'Old', modifier: -5)             # 10% (1-2)
cheap = Quality.create(name: 'Cheap', modifier: -3)         # 20% (3-6)
plain = Quality.create(name: 'Plain', modifier: 0)          # 35% (7-13)
fine = Quality.create(name: 'Fine', modifier: 2)            # 20% (14-17)
strong = Quality.create(name: 'Strong', modifier: 5)        # 10% (18-19)
master = Quality.create(name: 'Masterwork', modifier: 10)   # 5%  (20)

## ENCHANTS ##
none = Enchant.create(name: 'none', bonus: 0, imbue: 'none')

fire1 = Enchant.create(name: 'Lesser Burning', bonus: 6, imbue: 'fire')         # 9 vs Tundra / 3 vs Desert
fire2 = Enchant.create(name: 'Burning', bonus: 12, imbue: 'fire')               # 18 vs Tundra / 6 vs Desert
fire3 = Enchant.create(name: 'Greater Burning', bonus: 18, imbue: 'fire')       # 27 vs Tundra / 9 vs Desert

ice1 = Enchant.create(name: 'Lesser Slow', bonus: 6, imbue: 'ice')              # 9 vs Desert / 3 vs Tundra
ice2 = Enchant.create(name: 'Slow', bonus: 12, imbue: 'ice')                    # 18 vs Desert / 6 vs Tundra
ice3 = Enchant.create(name: 'Greater Slow', bonus: 18, imbue: 'ice')            # 27 vs Desert / 9 vs Tundra

earth1 = Enchant.create(name: 'Lesser Agony', bonus: 6, imbue: 'earth')         # 9 vs Forest / 3 vs Mountain
earth2 = Enchant.create(name: 'Agony', bonus: 12, imbue: 'earth')               # 18 vs Forest / 6 vs Mountain
earth3 = Enchant.create(name: 'Greater Agony', bonus: 18, imbue: 'earth')       # 27 vs Forest / 9 vs Mountain

nature1 = Enchant.create(name: 'Lesser Lifesteal', bonus: 6, imbue: 'nature')   # 9 vs Mountain / 3 vs Forest
nature2 = Enchant.create(name: 'Lifesteal', bonus: 12, imbue: 'nature')         # 18 vs Mountain / 6 vs Forest
nature3 = Enchant.create(name: 'Greater Lifesteal', bonus: 18, imbue: 'nature') # 27 vs Mountain / 9 vs Forest

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
