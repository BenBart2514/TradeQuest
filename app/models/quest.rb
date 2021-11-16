class Quest < ApplicationRecord
  has_many :heros

  validates :title, presence: true
  validates :description, presence: true
  validates :element, presence: true
  validates :resistance, presence: true
  validates :weakness, presence: true
end
