class CreateJoinTableRestaurantsCategories < ActiveRecord::Migration[6.1]
  def change
    create_join_table :restaurants, :categories do |t|
      t.index [:restaurant_id, :category_id]
    end
  end
end
