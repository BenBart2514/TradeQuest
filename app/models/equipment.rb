class Equipment < ApplicationRecord
  belongs_to :hero
  
  has_one :weapon
  has_one :item
end
