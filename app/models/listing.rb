class Listing < ApplicationRecord
  belongs_to :hero
  has_one :item
  has_one :weapon

  validates :hero, presence: true
  validates :price, presence: true

  validate :item_xor_weapon

  private

  def item_xor_weapon
    unless item.blank? ^ payment.blank?
      errors.add(:base, 'Must have either an item or weapon but not both')
    end
  end
end
