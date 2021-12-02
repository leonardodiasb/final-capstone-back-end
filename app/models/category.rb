class Category < ApplicationRecord
  has_many_and_belongs_to :restaurants

  validates :name, presence: true
end
