class Restaurant < ApplicationRecord
  has_many :reservations
  has_and_belongs_to_many :shifts, -> { select(:id, :name) }
  has_and_belongs_to_many :categories, -> { select(:id, :name) }

  validates :name, presence: true
  validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :reservation_spots, numericality: { greater_than_or_equal_to: 1 }
  validates :image, presence: true, url: true

  def spots(date)
    date_reservations = []
    reservations.each do |res|
      date_reservations.push(res) unless res.date != DateTime.parse(date)
    end

    reservations_per_shift = {}
    date_reservations.each do |res|
      if reservations_per_shift.has_key?(res.shift)
        reservations_per_shift[res.shift] += 1
      else
        reservations_per_shift[res.shift] = 1
      end
    end

    spots_avail_date = {}
    shifts.each do |sh|
      spots_avail_date[sh] = reservation_spots - reservations_per_shift[sh.name]
    end

    spots_avail_date
  end

  def self.json_list
    order(name: :asc)
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
