class Enchant < ApplicationRecord
  has_many :weapons, dependent: :destroy
  
  validates :name, presence: true
  validates :bonus, presence: true
  validates :imbue, presence: true
end
