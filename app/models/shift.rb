class Shift < ApplicationRecord
  belongs_to :restaurant

  validates :name,
            inclusion: { in: ['Breakfast', 'Lunch', 'Dinner'] }
end
