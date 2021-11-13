class Type < ApplicationRecord
  has_many :weapons, dependent: :destroy

  validates :name, presence: true
  validates :damage, presence: true
  validates :durability, presence: true
end
