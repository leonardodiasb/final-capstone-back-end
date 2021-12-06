class Shift < ApplicationRecord
  has_and_belongs_to_many :restaurants

  validates :name, presence: true

  def self.json_list
    all.map do |shift|
      {
        id: shift.id,
        name: shift.name
      }
    end
  end
end
