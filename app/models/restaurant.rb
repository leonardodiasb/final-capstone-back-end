class Restaurant < ApplicationRecord
  has_many :reservations
  has_many_and_belongs_to :shifts
  has_many_and_belongs_to :categories

  validates :name, presence: true
  validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :reservation_spots, numericality: { greater_than_or_equal_to: 1 }
  validates :image, presence: true, url: true
end
