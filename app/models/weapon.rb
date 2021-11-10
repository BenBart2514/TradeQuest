class Weapon < ApplicationRecord
    belongs_to :quality
    belongs_to :type
    belongs_to :enchant
    
    validates :name, presence: true
    validates :quality, presence: true
    validates :type, presence: true
    validates :enchant, presence: true
end
