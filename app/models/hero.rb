class Hero < ApplicationRecord
  belongs_to :user
  has_one :inventory

  validates :name, presence: true
  validates :life, presence: true
  validates :gold, presence: true
  validates :renown, presence: true
end
