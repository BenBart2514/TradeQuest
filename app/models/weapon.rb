class Weapon < ApplicationRecord
  belongs_to :hero, optional: true
  belongs_to :quality
  belongs_to :type
  belongs_to :enchant, optional: true

  validates :name, presence: true
  validates :quality, presence: true
  validates :type, presence: true
  validates :uses, presence: true
end
