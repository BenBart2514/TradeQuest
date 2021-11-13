class Item < ApplicationRecord
  belongs_to :hero, optional: true

  validates :name, presence: true
  validates :level, presence: true
  validates :element, presence: true
end
