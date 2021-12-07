class Restaurant < ApplicationRecord
  has_many :reservations
  has_and_belongs_to_many :shifts, -> { select(:id, :name) }
  has_and_belongs_to_many :categories, -> { select(:id, :name) }

  # accepts_nested_attributes_for :shifts

  validates :name, presence: true
  validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true
  validates :reservation_spots, numericality: { greater_than_or_equal_to: 1 }, presence: true
  validates :image, presence: true, url: true
  validates :description, presence: true

  def self.json_list
    order(id: :desc)
      .includes(:shifts, :categories)
      .map do |restaurant|
      {
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        reservation_spots: restaurant.reservation_spots,
        image: restaurant.image,
        price_range: restaurant.price_range,
        shifts: restaurant.shifts,
        categories: restaurant.categories
      }
    end
  end
end
