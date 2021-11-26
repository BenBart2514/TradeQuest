class Item < ApplicationRecord
  scope :for_sale, -> { where.not(price: nil).order(:level, :element, :price) }

  belongs_to :hero, optional: true

  has_one_attached :image, dependent: :purge_later

  validates :level, presence: true
  validates :element, presence: true
end
