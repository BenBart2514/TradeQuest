class Hero < ApplicationRecord
  belongs_to :user
  has_many :weapons, dependent: :destroy
  has_many :items, dependent: :destroy
  has_one :quest
  has_one :equipment, dependent: :destroy

  validates :name, presence: true
  validates :life, presence: true
  validates :gold, presence: true
  validates :renown, presence: true
end
