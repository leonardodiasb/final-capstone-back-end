class Category < ApplicationRecord
  has_and_belongs_to_many :restaurants

  validates :name, presence: true

  def self.json_list
    all.map do |cat|
      {
        id: cat.id,
        name: cat.name
      }
    end
  end
end
