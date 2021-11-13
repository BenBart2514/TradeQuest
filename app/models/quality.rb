class Quality < ApplicationRecord
  has_many :weapons, dependent: :destroy

  validates :name, presence: true
  validates :modifier, presence: true
end
