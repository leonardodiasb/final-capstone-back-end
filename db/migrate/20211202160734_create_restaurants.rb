class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :reservation_spots
      t.integer :price_range

      t.timestamps
    end
  end
end
