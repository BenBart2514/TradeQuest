class Item < ApplicationRecord
  belongs_to :hero, optional: true

  has_one_attached :image, dependent: :purge_later

  validates :level, presence: true
  validates :element, presence: true
end
