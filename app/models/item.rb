class Item < ApplicationRecord
  belongs_to :inventory

  validates :name, presence: true
  validates :level, presence: true
  validates :element, presence: true
end
