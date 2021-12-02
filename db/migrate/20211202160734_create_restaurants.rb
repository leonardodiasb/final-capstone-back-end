class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.integer :reservation_spots
      t.integer :price_range
      t.string :category

      t.timestamps
    end
  end
end
