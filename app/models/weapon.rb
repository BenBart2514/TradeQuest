class Weapon < ApplicationRecord
    belongs_to :quality
    belongs_to :type
    belongs_to :enchant
    belongs_to :inventory
    
    validates :name, presence: true
    validates :quality, presence: true
    validates :type, presence: true
    validates :enchant, presence: true
    validates :uses, presence: true
end
