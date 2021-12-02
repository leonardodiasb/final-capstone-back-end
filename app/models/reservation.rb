class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :date, presence: true
  validates :shift,
            inclusion: { in: %w[Breakfast Lunch Dinner] }
end
