class Restaurant < ApplicationRecord
  has_many :reservations
  has_and_belongs_to_many :shifts
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :reservation_spots, numericality: { greater_than_or_equal_to: 1 }
  validates :image, presence: true, url: true
end
