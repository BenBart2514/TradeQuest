class Inventory < ApplicationRecord
  belongs_to :hero
  has_many :items
  has_many :weapons
end
