class Weapon < ApplicationRecord
  scope :for_sale, -> { where.not(price: nil).order(:type_id, :quality_id, :enchant_id, :price) }

  belongs_to :hero, optional: true
  belongs_to :quality
  belongs_to :type
  belongs_to :enchant, optional: true

  has_one_attached :image, dependent: :purge_later

  validates :quality, presence: true
  validates :type, presence: true
  validates :uses, presence: true
end
