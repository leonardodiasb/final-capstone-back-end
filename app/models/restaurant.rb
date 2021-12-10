class Restaurant < ApplicationRecord
  has_many :reservations
  has_and_belongs_to_many :shifts, -> { select(:id, :name) }
  has_and_belongs_to_many :categories, -> { select(:id, :name) }

  validates :name, presence: true
  validates :price_range, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true
  validates :reservation_spots, numericality: { greater_than_or_equal_to: 1 }, presence: true
  validates :image, presence: true, url: true
  validates :description, presence: true

  def spots(date)
    date_reservations = []
    reservations.each do |res|
      date_reservations.push(res) unless res.date != DateTime.parse(date)
    end

    spots_avail_date = {}
    if date_reservations.empty?
      shifts.each do |sh|
        spots_avail_date[sh.name] = reservation_spots
      end
    else
      reservations_per_shift = {}
      date_reservations.each do |res|
        if reservations_per_shift.key?(res.shift)
          reservations_per_shift[res.shift] += 1
        else
          reservations_per_shift[res.shift] = 1
        end
      end

      shifts.each do |sh|
        spots_avail_date[sh.name] = reservation_spots - reservations_per_shift[sh.name]
      end
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

  def self.json_delete_list
    order(name: :asc)
      .map do |restaurant|
      {
        id: restaurant.id,
        name: restaurant.name
      }
    end
  end
end
