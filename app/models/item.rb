class Item < ApplicationRecord
  belongs_to :inventory

  has_one_attached :item_image

  validates :name, presence: true
  validates :level, presence: true
  validates :element, presence: true
end
