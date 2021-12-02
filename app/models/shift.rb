class Shift < ApplicationRecord
  belongs_to :restaurant

  validates :name,
            inclusion: { in: %w[Breakfast Lunch Dinner] }
end
